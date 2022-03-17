package com.memo.test;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TestController {

	// string
	@ResponseBody
	@RequestMapping("/test1")
	public String test1() {
		return "Hello World";
	}
	
	// json
	@ResponseBody
	@RequestMapping("/test2")
	public Map<String, Object> test2() {
		Map<String, Object> result = new HashMap<>();
		result.put("aaaa", 1234);
		result.put("bbbb", 233);
		result.put("cccc", 444);
		
		return result;
	}
	
	// jsp
	@RequestMapping("/test3")
	public String test3() {
		return "test/example";
	}
}
