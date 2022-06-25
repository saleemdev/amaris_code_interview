package com.example.springboot;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;


import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


import org.postgresql.util.PGobject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
// import com.google.code.gson;
@RestController
public class HelloController {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private Gson gson;
	private List<List<Object>> deeper;

	@GetMapping("/")
	public String index() {
		return "<h1>Greetings from Spring Boot!</h1>";
	}

	@GetMapping("/search")
	public ArrayList<HashMap<String, Object>> dbjson() {
		ArrayList<HashMap<String, Object>> parentList = new ArrayList<HashMap<String, Object>>();
		String[] columns = new String[]{"Professor Name", "courses"};
		// String sql = "SELECT  DISTINCT schedule.professor_id,professor.name as professor_name,schedule.course_id,course.name as course_name  FROM schedule inner join professor on schedule.professor_id::varchar=professor.id::varchar inner join course on schedule.course_id::varchar=course.id::varchar ORDER BY 1;";
		// String sql2 = "SELECT professor_name,JSON_AGG(JSON_BUILD_OBJECT(courses, results)) as courses FROM (select  professor.name AS professor_name,'courses' AS courses,JSON_AGG(ROW_TO_JSON(course)) AS results FROM schedule inner join professor on schedule.professor_id::varchar=professor.id::varchar inner join course on schedule.course_id::varchar=course.id::varchar GROUP BY 1,2) i GROUP BY 1 ORDER BY 1;";
		// String sql = "SELECT professor_name,JSON_AGG(JSON_BUILD_OBJECT(courses, results)) as courses FROM (select  professor.name AS professor_name,'courses' AS courses,JSON_AGG(ROW_TO_JSON(cast(row(course.name) as course_type))) AS results FROM schedule inner join professor on schedule.professor_id::varchar=professor.id::varchar inner join course on schedule.course_id::varchar=course.id::varchar GROUP BY 1,2) i GROUP BY 1 ORDER BY 1;";
		String sql = "SELECT professor_name,JSON_AGG(JSON_BUILD_OBJECT(courses, results)) as courses FROM (select  professor.name AS professor_name,'courses' AS courses,JSON_AGG(json_build_array(course.name) ) as results FROM schedule inner join professor on schedule.professor_id::varchar=professor.id::varchar inner join course on schedule.course_id::varchar=course.id::varchar GROUP BY 1,2) i GROUP BY 1 ORDER BY 1;";

		List<Map<String, Object>> rows = jdbcTemplate.queryForList(sql);
		
		for (Map row : rows) {
			//1. Declare a HashMap {k:V} store
			HashMap<String, Object> professorMap = new HashMap<String, Object>();
			Gson gson = new Gson();//Need it to parse the result of converting a Pgobject below
			Object courses = row.get("courses");	
			//2. Add professor Name to the pgObject
			professorMap.put("_name", row.get("professor_name")); //First row
			//3. Cast to a pgObject from the resultset map object above(courses)
			PGobject pg = (PGobject) courses;
			String theValue = pg.getValue();
			//4. The query returns a list, so I cast the result into alist too, 
			//But it is a string so I use gSon to convert it into a List Object
			List  parsedValue = (List) gson.fromJson(theValue, Object.class);
					
	
			Map<String, Object> theCourses = (Map<String, Object>) parsedValue.get(0);
			deeper = (List<List<Object>>) theCourses.get("courses");
			
			
			//5. But it is a nested list I flatten the nested list.
			List<Object> solution= flatten(deeper);
			//6. Finally add it to the Hashmap and repeat for the rest of the resultset
			professorMap.put("courses",solution);
			parentList.add(professorMap);
			
		}
		
		//7. Return the ArrayList of the Professors and their courses
		return parentList;
	}
	public static<T> List<T> flatten(List<List<T>> listOfLists) {
        return listOfLists.stream()
                .flatMap(List::stream)
                .collect(Collectors.toList());
    }

}
