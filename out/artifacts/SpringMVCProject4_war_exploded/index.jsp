<%--
  Created by IntelliJ IDEA.
  User: 12558
  Date: 09/08/2019
  Time: 00:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>index.jsp</title>
    <script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
  </head>
  <body>
  <h1>index.jsp</h1>
  <a href="${pageContext.request.contextPath}/testView">测试view</a><br>
  <hr>
  <a href="${pageContext.request.contextPath}/update.action/1">测试update更新</a><br>
  <%--img src="${pageContext.request.contextPath}/images/2101521420-14.jpg">--%>
  <hr>
  <input type="button" id="btn1" value="请求JSON---返回一个对象 "><br>
  <input type="button" id="btn2" value="请求JSON---返回一个List集合"><br>
  <input type="button" id="btn3" value="请求JSON---返回一个Map集合"><br>
  <hr>

  <form id="myform">
    user:<input type="text" name="username"><br>
    age:<input type="text" name="age" ><br>
    爱好:<input type="checkbox" name="hobby" value="篮球"> 篮球
    <input type="checkbox" name="hobby" value="乒乓球"> 乒乓球
    <input type="checkbox" name="hobby" value="足球"> 足球
    <input type="button" id="formbtn" value="发送form">
  </form>

  <%--SpringMVC-@RequestBody获取文件信息--%>
  <hr>
  <form action="${pageContext.request.contextPath}/myform" method="post" enctype="multipart/form-data">
      <input type="file" name="myfile"><br>
      <input type="submit" value="提交">
  </form>

  <script>
    //表单序列化转Json
    (function($){
      $.fn.serializeJson=function(){
        var serializeObj={};
        var array=this.serializeArray();
        var str=this.serialize();
        $(array).each(function(){
          if(serializeObj[this.name]){
            if($.isArray(serializeObj[this.name])){
              serializeObj[this.name].push(this.value);
            }else{
              serializeObj[this.name]=[serializeObj[this.name],this.value];
            }
          }else{
            serializeObj[this.name]=this.value;
          }
        });
        return serializeObj;
      };
    })(jQuery);

    $(function () {
      $("#btn1").click(function () {
        //发送Ajax请求
        $.post("${pageContext.request.contextPath}/testJson1.action",function (data) {
          console.log(data);
        });
      });

      $("#formbtn").click(function () {
        //获取表单中所有的参数
        var serialize = $("#myform").serializeJson();//表单序列化
        console.log(serialize);
        console.log(JSON.stringify(serialize));
        console.log(typeof serialize.hobby);
          //解决hobby勾选多个时为数组类型、勾选一个时为string字符串导致报错的问题
        if(typeof serialize.hobby =="string"){
            serialize.hobby = new Array(serialize.hobby);//如果hobby为字符串，就把hobby转换为数组类型再重新赋值
        }

        $.ajax({
          type:"post",
          url:"${pageContext.request.contextPath}/formJson",
          data:JSON.stringify(serialize),
          dataType:'json',
          contentType:'application/json',
            success:function (data) {
              alert("成功");
                console.log(data);
          },
            error:function (data) {
                alert("失败");
                console.log(data);
            }
        });

      })
    });

    $(function () {
      $("#btn2").click(function () {
        $.post("${pageContext.request.contextPath}/testJson2.action",function (data) {
          console.log(data);
        })
      })
    })
    $(function () {
      $("#btn3").click(function () {
        $.post("${pageContext.request.contextPath}/testJson3.action",function (data) {
          console.log(data);
          //参数发送给服务器

/*          $.post("${pageContext.request.contextPath}/formJson",serialize,function () {
            console.log(data)
          })*/

        })
      })

    })
  </script>
  </body>
</html>
