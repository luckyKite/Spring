<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
<jsp:include page="../common/header.jsp" /> 
  <h2>SpringMVC03</h2>
  <div class="panel panel-default">
    <div class="panel-heading">로그인화면</div>
    <div class="panel-body">
    	<form name="frm" action="${contextPath}/memLogin.do" method="post">
    		<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd;">   		
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">아이디</td>
    				<td><input id="memID" name="memID" class="form-control" type="text" maxlength="20" placeholder="아이디를 입력하세요" /></td>
    				<td style="width: 110px;"><button type="button" class="btn btn-primary btn-sm" onclick="registerCheck();">중복확인</button></td>
    			</tr>
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">비밀번호</td>
    				<td colspan="2"><input id="memPassword" name="memPassword" class="form-control" type="password" maxlength="20" placeholder="비밀번호를 입력하세요" /></td>
    			</tr>		
    			<tr>
    				<td colspan="2" style="text-align: left;">
    					<!-- span 부분을 <span ~~/> 형식으로 두면, 폼을 작성하는 과정에서 등록 버튼이 안보이는 문제가 발생한다. <span></span>으로 작성해야 한다.  -->
    					<span id="submit" style="color: red"></span><input type="button" class="btn btn-primary btn-sm pull-right" value="로그인" />
    				</td>
    			</tr>
    		</table>
    	</form>
    </div>
    <div class="panel-footer">스프1탄_인프런(egg)</div>
  </div>
</div>

</body>
</html>
