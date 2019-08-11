# SpringMVCProject4总结

## SpringMVC测试工程4：

### 项目环境：

	IDE工具：IDEA、JDK1.8+Tomcat8.5.33、SpringMVC框架版本：spring-webmvc-5.0.7.RELEASE
	所需jar包：存放在\web\WEB-INF\lib目录下

#### 一.mvc:view-controller

					当我们发送一个请求时,如果没有找到对应的mapping
					则会对配置文件当中匹配mvc:view-controller		
					
#### 二.<mvc:annotation-driven />

1.<mvc:annotation-driven /> 是一种简写形式，会自动注册三个Bean：

	RequestMappingHandlerMapping
	RequestMappingHandlerAdapter
	ExceptionHandlerExceptionResolver
	
2.提供了：

	数据绑定支持，
	@NumberFormatannotation支持，
	@DateTimeFormat支持，
	@Valid支持，读写XML的支持（JAXB），
	读写JSON的支持（Jackson）。

#### 三.服务器表单校验

1.JSR 

	JSR 303 是 Java 为 Bean 数据合法性校验提供的标准框架，它已经包含在 JavaEE 6.0 中 
	JSR 303 通过在 Bean 属性上标注类似于 @NotNull、@Max 等标准的注解
	指定校验规则，并通过标准的验证接口对 Bean 进行验证
	
2.Hibernate Validator   
	
	是 JSR 303 的一个参考实现，
	除支持所有标准的校验注解外，它还支持以下的扩展注解
	
3.常用校验规则——>Bean Validation 中内置的约束

	@Null   被注释的元素必须为 null       
	@NotNull    被注释的元素必须不为 null       
	@AssertTrue     被注释的元素必须为 true       
	@AssertFalse    被注释的元素必须为 false       
	@Min(value)     被注释的元素必须是一个数字，其值必须大于等于指定的最小值       
	@Max(value)     被注释的元素必须是一个数字，其值必须小于等于指定的最大值       
	@DecimalMin(value)  被注释的元素必须是一个数字，其值必须大于等于指定的最小值       
	@DecimalMax(value)  被注释的元素必须是一个数字，其值必须小于等于指定的最大值       
	@Size(max=, min=)   被注释的元素的大小必须在指定的范围内       
	@Digits (integer, fraction)     被注释的元素必须是一个数字，其值必须在可接受的范围内       
	@Past   被注释的元素必须是一个过去的日期       
	@Future     被注释的元素必须是一个将来的日期       
	@Pattern(regex=,flag=)  被注释的元素必须符合指定的正则表达式       
	
4.常用校验规则——>Hibernate Validator 附加的约束  

	@NotBlank(message =)   验证字符串非null，且长度必须大于0       
	@Email  被注释的元素必须是电子邮箱地址       
	@Length(min=,max=)  被注释的字符串的大小必须在指定的范围内       
	@NotEmpty   被注释的字符串的必须非空       
	@Range(min=,max=,message=)  被注释的元素必须在合适的范围内 
	

#### 四.访问静态资源  

1.概述
		在进行Spring MVC的配置时，通常我们会配置一个dispatcher servlet用于处理对应的URL
		在设置url-pattern时可以设置三种形式
			/*
				拦截所有   jsp  js png .css  真的全拦截.不建议使用
			/
				拦截所有,不包括jsp,包含.js .png.css     建议使用 
			*.action   *.do
				拦截以do action 结尾的请求
				
2.url-pattern为/时访问静态资源

	方式1-<mvc:default-servlet-handler/>
	方式2- 采用spring自带<mvc:resources>方法：
		 <mvc:annotation-driven />
		<mvc:resources location="/img/" mapping="/img/**"/>   
		<mvc:resources location="/js/" mapping="/js/**"/>    
		<mvc:resources location="/css/" mapping="/css/**"/>  

#### 五.Json处理

1.概述

	当前端使用Ajax发送请求时,服务器要以JSON的数据格式响应给浏览器
	
2.使用方式：@ResponseBody来实现；注解方式

3.@ResponseBody

	1.添加json处理相关jar包
	2.在配置文件当中写上<mvc:annotation-driven/>
	3.设置映射方法的返回值为@ResponseBody
		* 方式1-直接返回一个对象
		* 方式2-返回一个List集合
		* 方式3-返回一个Map集合
		
4.表单序列化

	1.序列化转Json
	
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
	
5.@RequestBody

	作用：
	
		默认情况下我们发送的都是Content-Type: 不是application/x-www-form-urlencoded
		直接使用@RequestParam接收参数
		如果不是Content-Type: 不是application/x-www-form-urlencoded编码的内容，例如application/json, application/xml等；
		使用@RequestBody接收
		
#### 六.视图解析器

视图解析器概述：

	请求处理方法执行完成后，最终返回一个 ModelAndView 对象
	对于那些返回 String，View 或 ModeMap 等类型的处理方法
	Spring MVC 也会在内部将它们装配成一个 ModelAndView 对象
	它包含了逻辑名和模型对象的视图
	Spring MVC 借助视图解析器（ViewResolver）得到最终的视图对象（View），最终的视图可以是 JSP 
	
视图：

	视图的作用是渲染模型数据，将模型里的数据以某种形式呈现给客户
	视图对象由视图解析器负责实例化
	在org.springframework.web.servlet 包中定义了一个高度抽象的 View 接口
	
#### 七.源码分析：执行DispatcherServlet

1.获取mapping映射
	
2.获取适配器
	
4.处理转发页面
	
5.在方法内部渲染页面
	
6.创建视图对象
	
7.调用View对象渲染页面
	
8.在render内部解析数据

9.转发到jsp页面
	
