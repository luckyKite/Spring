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
  
<script type="text/javascript">
	//msgType이 empty가 아닌 경우, 메세지 모달 출력
	$(document).ready(function(){
		if(${!empty msgType}) {
			$("#messageType").attr("class", "modal-content panel-warning");
			$("#myMessage").modal("show"); 
		}
	});

	//아이디 중복체크
	function registerCheck() {
		var memID = $("#memID").val();
		$.ajax({
			url: "${contextPath}/memRegisterCheck.do",
			type: "get",
			data: {"memID":memID}, //,가 아니고 : 로 표기함!!! thanks to 임전임
			success: function(result) {
				//alert(result);
				//중복유무 출력
				//result=1: 사용할 수 있는 아이디, 0: 사용할 수 없는 아이디
				if(result==1) {
					$("#checkMessage").html("사용할 수 있는 아이디입니다.");
					$("#checkType").attr("class", "modal-content panel-success");
				} else {
					$("#checkMessage").html("사용할 수 없는 아이디입니다.");
					$("#checkType").attr("class", "modal-content panel-warning");
				}
				$("#myModal").modal("show"); 
			},
			error: function() { alert("error"); }
		});
	}
	
	//비밀번호 일치여부 확인
	function passwordCheck() {
		var memPassword1 = $("#memPassword1").val();
		var memPassword2 = $("#memPassword2").val();
		if(memPassword1 != memPassword2) {
			$("#passMessage").html("비밀번호가 서로 일치하지 않습니다.");
		} else {
			$("#passMessage").html("");
			$("#memPassword").val(memPassword1);
		}	
	}
	
	//나이부분을 체크하고
	function goInsert() {
		var memAge = $("#memAge").val();
		if(memAge==null || memAge=="" || memAge==0) {
			alert("나이를 입력하세요.");
			return false;
		}
		document.frm.submit(); //전송
	}
</script>
</head>
<body>

<div class="container">
<jsp:include page="../common/header.jsp" /> 
  <h2>SpringMVC05</h2>
  <div class="panel panel-default">
    <div class="panel-heading">회원가입</div>
    <div class="panel-body">
    	<form name="frm" action="${contextPath}/memRegister.do" method="post">
    	<input type="hidden" id="memPassword" name="memPassword" value="" />
    		<table class="table table-bordered" style="text-align: center; border: 1px solid #dddddd;">    		
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">아이디</td>
    				<td><input id="memID" name="memID" class="form-control" type="text" maxlength="20" placeholder="아이디를 입력하세요" /></td>
    				<td style="width: 110px;"><button type="button" class="btn btn-primary btn-sm" onclick="registerCheck();">중복확인</button></td>
    			</tr>
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">비밀번호</td>
    				<td colspan="2"><input id="memPassword1" name="memPassword1" onkeyup="passwordCheck()" class="form-control" type="password" maxlength="20" placeholder="비밀번호를 입력하세요" /></td>
    			</tr>
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">비밀번호확인</td>
    				<td colspan="2"><input id="memPassword2" name="memPassword2" onkeyup="passwordCheck()" class="form-control" type="password" maxlength="20" placeholder="비밀번호를 한번 더 입력하세요" /></td>
    			</tr>
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">사용자이름</td>
    				<td colspan="2"><input id="memName" name="memName" class="form-control" type="text" maxlength="20" placeholder="사용자이름을 입력하세요" /></td>
    			</tr>
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">나이</td>
    				<td colspan="2"><input id="memAge" name="memAge" class="form-control" type="number" maxlength="20" placeholder="나이를 입력하세요" /></td>
    			</tr>
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">성별</td>
    				<td colspan="2">		
    					<div class="form-group" style="text-align: center; margin: 0 auto;">
    						<div class="btn-group" data-toggle="buttons">
    							<label class="btn btn-primary active">
    							<input type="radio" id="memGender" name="memGender" autocomplete="off" value="남자" checked />
    								남자
    							</label>
    							<label class="btn btn-primary">
    							<input type="radio" id="memGender" name="memGender" autocomplete="off" value="여자" />
    								여자
    							</label>
    						</div>
    					</div>
    				</td>
    			</tr>
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">이메일</td>
    				<td colspan="2"><input id="memEmail" name="memEmail" class="form-control" type="email" maxlength="20" placeholder="이메일을 입력하세요" /></td>
    			</tr>
    			<!-- 권한체크박스 추가 -->
    			<tr>
    				<td style="width: 110px; vertical-align: middle;">사용자권한</td>
    				<td colspan="2">
    					<input type="checkbox" name="authList[0].auth" value="ROLE_USER"> ROLE_USER
    					<input type="checkbox" name="authList[1].auth" value="ROLE_MANAGER"> ROLE_MANAGER
    					<input type="checkbox" name="authList[2].auth" value="ROLE_ADMIN"> ROLE_ADMIN
    				</td>
    			</tr>
    			
    			<tr>
    				<td colspan="3" style="text-align: left;">
    					<!-- span 부분을 <span ~~/> 형식으로 두면, 폼을 작성하는 과정에서 등록 버튼이 안보이는 문제가 발생한다. <span></span>으로 작성해야 한다.  -->
    					<span id="passMessage" style="color: red"></span><input type="button" class="btn btn-primary btn-sm pull-right" value="등록" onclick="goInsert()"/>
    				</td>
    			</tr>
    			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    		</table>
    	</form>
    </div>
    
    <!-- 다이얼로그창(모달) -->
    <div id="myModal" class="modal fade" role="dialog">
	  <div class="modal-dialog">	
	    <!-- Modal content-->
	    <div id="checkType" class="modal-content panel-info">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">메세지 확인</h4>
	      </div>
	      <div class="modal-body">
	        <p id="checkMessage"></p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 실패 메세지를 출력 -->
	<!-- 다이얼로그창(모달) -->
	<!-- js는 오타를 알려주지않아요... 잘 확인할 것!!! 오류를 함께 찾아준 임전임에게 감사를 전하며...ㅜㅜ -->
    <div id="myMessage" class="modal fade" role="dialog">
	  <div class="modal-dialog">	
	    <!-- Modal content-->
	    <div id="messageType" class="modal-content panel-info">
	      <div class="modal-header panel-heading">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">${msgType}</h4>
	      </div>
	      <div class="modal-body">
	        <p>${msg}</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
    <div class="panel-footer">스프1탄_인프런(egg)</div>
  </div>
</div>

</body>
</html>