package web.controller;


import domain.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Controller
public class MyController  {

    @RequestMapping("update.action/{id}")
    public String update(@PathVariable Integer id, Model model){
        System.out.println(id);
        User user = new User();
        user.setUsername("魏广逸");
        user.setAge("10");
        user.setGender(0);
        java.lang.String[] hobby = new java.lang.String[]{"唱","跳","Rap","篮球"};
        user.setHobby(hobby);
        model.addAttribute("user",user);

        ArrayList<Object> arrayList = new ArrayList<>();
        arrayList.add("唱");
        arrayList.add("跳");
        arrayList.add("Rap");
        arrayList.add("篮球");
        arrayList.add("music");
        model.addAttribute("allhobbys",arrayList);
        return "/result.jsp";
    }

    @RequestMapping("update2")
    public String update2(User user){
        System.out.println(user);
        return "/result.jsp";
    }

    @RequestMapping("testJson1.action")
    @ResponseBody   //设置映射方法的返回值为@ResponseBody,把返回的user解析成json数据
    public User testJson(){//返回一个对象
        User user1 = new User();
        user1.setUsername("Luzhibin");
        user1.setAge("18");
        return user1;
    }

    @RequestMapping("testJson2.action")
    @ResponseBody
    //返回一个List集合
    public List<User> testJson2(){
        User user2 = new User();
        user2.setUsername("魏广逸");
        user2.setAge("18");
        user2.setGender(1);
        String[] hobby = new String[]{"唱","跳","rap","篮球"};
        user2.setHobby(hobby);

        ArrayList<User> arrayList = new ArrayList<>();
        arrayList.add(user2);

        return arrayList;
    }

    @RequestMapping("testJson3.action")
    @ResponseBody
    //返回一个Map集合
    public HashMap<Object, Object> testJson3(){
        User user2 = new User();
        user2.setUsername("魏广逸");
        user2.setAge("18");
        user2.setGender(1);
        String[] hobby = new String[]{"唱","跳","rap","篮球"};
        user2.setHobby(hobby);

        ArrayList<User> arrayList = new ArrayList<>();
        arrayList.add(user2);

        HashMap<Object, Object> hashMap = new HashMap<>();
        hashMap.put("name","luzhibin");
        hashMap.put("list",arrayList);

        return hashMap;
    }

    @RequestMapping("formJson")
    @ResponseBody
    public String formJson(@RequestBody User user){
        System.out.println(user);
        return "success";
    }

    @RequestMapping("myform")
    public String myform(@RequestBody String body){
        System.out.println(body);
        return "result2.jsp";
    }
}
