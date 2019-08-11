# SpringMVCProject4总结

## SpringMVC测试工程4：

### 项目环境：

	IDE工具：IDEA、JDK1.8+Tomcat8.5.33、SpringMVC框架版本：spring-webmvc-5.0.7.RELEASE
	所需jar包：存放在\web\WEB-INF\lib目录下

#### 一.mvc:view-controller

					当我们发送一个请求时,如果没有找到对应的mapping
					则会对配置文件当中匹配mvc:view-controller		
					
#### 二.<mvc:annotation-driven />

1.	<mvc:annotation-driven /> 是一种简写形式，会自动注册三个Bean：

	RequestMappingHandlerMapping、
	RequestMappingHandlerAdapter 
	ExceptionHandlerExceptionResolver
	
2.提供了：

	数据绑定支持，
	@NumberFormatannotation支持，
	@DateTimeFormat支持，
	@Valid支持，读写XML的支持（JAXB），
	读写JSON的支持（Jackson）。
	
		