<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring MVC03</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  	$(document).ready(function(){
  		loadList();
  	});
  	
  	function loadList() {
  		//서버와 통신 : 게시판 리스트 가져오기
  		$.ajax({
  			url: "board/all",
  			type: "get",
  			dataType: "json",
  			success: makeView, //콜백함수
  			error: function(){ alert("error"); }
  		});
  	}
  								//     0    1    2   --->
  	function makeView(data) { //data=[{ }, { }, { }, ...]
  		var listHtml="<table class='table table-bordered'>";
  		listHtml+="<tr>";
  		listHtml+="<td>번호</td>";
  		listHtml+="<td>제목</td>";
  		listHtml+="<td>작성자</td>";
  		listHtml+="<td>작성일</td>";
  		listHtml+="<td>조회수</td>";
  		listHtml+="</tr>"; 		
  		$.each(data, function(index,obj) { //obj={"idx":5, "title":"게시판~~", ...}
  			listHtml+="<tr>";
  	  		listHtml+="<td>"+obj.idx+"</td>";
  	  		listHtml+="<td id='t"+obj.idx+"'><a href='javascript:goContent("+obj.idx+")'>"+obj.title+"</a></td>";
  	  		listHtml+="<td>"+obj.writer+"</td>";
  	  		listHtml+="<td>"+obj.indate.split(' ')[0]+"</td>";
  	  		listHtml+="<td id='cnt"+obj.idx+"'>"+obj.count+"</td>";
  	  		listHtml+="</tr>";
  	  		
	  	  	listHtml+="<tr id='c"+obj.idx+"' style='display:none'>";
	  	  	listHtml+="<td>내용</td>";
	  	 	listHtml+="<td colspan='4'>";
	  	 	listHtml+="<textarea id='ta"+obj.idx+"' readonly rows='7' class='form-control'></textarea>";
	  	 	listHtml+="<br/>";
	  	 	listHtml+="<span id='ub"+obj.idx+"'><button class='btn btn-success btn-sm' onclick='goUpdateForm("+obj.idx+")'>수정화면</button></span>&nbsp;";
	  	 	listHtml+="<button class='btn btn-warning btn-sm' onclick='goDelete("+obj.idx+")'>삭제</button>";
	  	 	listHtml+="</td>";
	  		listHtml+="</tr>";
  		}); 
  		
  		listHtml+="<tr>";
  		listHtml+="<td colspan='5'>";
  		listHtml+="<button class='btn btn-primary btn-sm' onclick='goForm()'>글쓰기</button>"
  		listHtml+="</td>"
  		listHtml+="</tr>"
  		listHtml+="</table>";
  		$("#view").html(listHtml);
  		
  		$("#view").css("display", "block"); //보이고
  		$("#wform").css("display", "none"); //감추고
  	}
  	
  	function goForm() {
  		$("#view").css("display", "none"); //감추고
  		$("#wform").css("display", "block"); //보이고
  	}
  	
  	function goList() {
  		$("#view").css("display", "block"); //보이고
  		$("#wform").css("display", "none"); //감추고
  	}
  	
  	function goInsert() {
  		//낱개를 가져오는 경우
  		//var title =	$("#title").val();
  		//var content = $("#content").val();
  		//var writer = $("writer").val();
  		
  		//한번에 가져오면 훨씬 편하다 
  		var fData = $("#frm").serialize();
  		//alert(fData); --> title=111&content=222&writer=333
  		
  		$.ajax({
  			url: "board/new",
  			type: "post",
  			data: fData,
  			success: loadList,
  			error: function(){ alert("error"); }
  		});
  		
  		//폼 초기화
  		//$("#title").val("");
  		//$("#content").val("");
  		//$("writer").val("");
  		$("#fclear").trigger("click");
  	}
  	
  	function goContent(idx) { //idx=11, 10, 9, ...
  		if($("#c"+idx).css("display")=="none") { //안보이는 상태이면
  			//펼쳐질 때 상세보기 화면을 보여줌
  			$.ajax({
  				url: "board/"+idx,
  				type: "get",
  				dataType: "json",
  				success: function(data) { //data= { "content": ~~ }
  					$("#ta"+idx).val(data.content);
  				},
  				error: function() { alert("error"); }
  			});  	
  		
  			$("#c"+idx).css("display", "table-row"); //보이게
  			$("#ta"+idx).attr("readonly", true); //열릴때는 읽기전용이다
  		} else {
  			$("#c"+idx).css("display", "none"); //안보이게 감춘다
  			
  			//닫힐때, 조회수를 1 증가시키기 위해서
  			$.ajax({
  				url: "board/count/"+idx,
  				type: "put",
  				dataType: "json",
  				success: function(data) {
  					$("#cnt"+idx).text(data.count);
  				},
  				error: function() { alert("error"); }
  			});
  		}
  	}
  	
  	function goDelete(idx) {
  		$.ajax({
  			url: "board/"+idx,
  			type: "delete",
  			success: loadList,
  			error: function(){ alert("error"); }
  		});
  	}
  	
  	function goUpdateForm(idx) { //idx=10, 9, 8, ...
  		$("#ta"+idx).attr("readonly", false); //읽기만가능인 것을 false로 만든다 --> 수정가능
  		var title = $("#t"+idx).text();
  		var newInput = "<input type='text' id='nt"+idx+"' class='form-control' value='"+title+"'/>"; //기존 제목 가져옴
  		
  		$("#t"+idx).html(newInput); //제목부분 새로 쓸 수 있게함
  		
  		var newButton = "<button class='btn btn-primary btn-sm' onclick='goUpdate("+idx+")'>수정</button>"; //수정화면 들어가면 나온다
  		$("#ub"+idx).html(newButton);
  	}
  	
  	function goUpdate(idx) {
  		//# 부분 빠뜨리지 않도록 한다 --> "#ta" 
  		var title = $("#nt"+idx).val();
  		var content = $("#ta"+idx).val();
  		//ajax 사용할때 --> ;말고 , 로 연결함! 2번 틀렸음(주의)
  		$.ajax({
  			url: "board/update",
  			type: "put",
  			contentType: 'application/json;charset=utf-8', //json형식으로 보낼때 적어줘야한다
  			data: JSON.stringify({"idx":idx, "title":title,"content":content}), //JSON 형식의 object로 전달
  			success: loadList,
  			error: function() { alert("error"); }
  		});
  	}
  </script>
</head>
<body>
 
<div class="container">
  <h2>Spring MVC03</h2>
  <div class="panel panel-default">
    <div class="panel-heading">Board</div>
    <div class="panel-body" id="view">Panel Content</div>
    <div class="panel-body" id="wform" style="display: none">
    	<form id="frm">
	    	<table class="table">
	    		<tr>
	    			<td>제목</td>
	    			<td><input type="text" id="title" name="title" class="form-control"/></td>
	    		</tr>
	    		<tr>
	    			<td>내용</td>
	    			<!-- textarea는 하나에서 닫기까지 하면 구성 이상해짐. 앞 뒤로 닫아줘야 한다. -->
	    			<td><textarea rows="7" id="content" name="content" class="form-control"></textarea></td>
	    		</tr>
	    		<tr>
	    			<td>작성자</td>
	    			<td><input type="text" id="writer" name="writer" class="form-control"/></td>
	    		</tr>
	    		<tr>
	    			<td colspan="2" align="center">
	    				<button type="button" class="btn btn-success btn-sm" onclick="goInsert()">등록</button>
	    				<button type="reset" class="btn btn-warning btn-sm" id="fclear">취소</button>
	    				<button type="button" class="btn btn-info btn-sm" onclick="goList()">리스트</button>
	    			</td>
	    		</tr>
	    	</table>
    	</form>
    </div>
    <div class="panel-footer">인프런_스프1탄_egg</div>
  </div>
</div>

</body>
</html>