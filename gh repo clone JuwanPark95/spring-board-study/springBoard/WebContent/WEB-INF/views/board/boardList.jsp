<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>list</title>
</head>

<body>
<table  align="center">
	<tr>
		<td align="right">
			total : <c:forEach items="${boardList}" var="one" end="0"> ${one.totalCnt} </c:forEach>
		</td>
	</tr>
	<tr>
		<td>
			<table id="boardTable" border = "1">
				<tr>
					<td width="80" align="center">
						Type
					</td>
					<td width="40" align="center">
						No
					</td>
					<td width="300" align="center">
						Title
					</td>
				</tr>
				<c:forEach items="${boardList}" var="list">
					<tr>
						<td align="center">
						<c:choose> 
						    <c:when test="${list.boardType eq 'a01'}">
						        <a>일반</a>
						    </c:when>
						    <c:when test="${list.boardType eq 'a02'}">
						        <a>Q&A</a>
						    </c:when>
						    <c:when test="${list.boardType eq 'a03'}">
						        <a>익명</a>
						    </c:when>
						    <c:when test="${list.boardType eq 'a04'}">
						        <a>자유</a>
						    </c:when>
						    <c:otherwise>
						        <a>???</a>
						    </c:otherwise>
						</c:choose>
						</td>
						<td>
							${list.boardNum}
						</td>
						<td>
							<a href = "/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}">${list.boardTitle}</a>
						</td>
					</tr>	
				</c:forEach>
			</table>
		</td>
	</tr>
	<tr>
		<td align="right">
			<a href ="/board/boardWrite.do">글쓰기</a>
		</td>
	</tr>
	<tr>
		<td align="left">
			<form action="/board/boardSeachList.do" id="frm" method="post">
				<label><input id="boardTypeAllCheckBox" type="checkbox">전체</label>

				<c:forEach items="${boardTypeList}" var="list2">
					<label><input class="boardTypeCheckBox" type="checkbox" name="boardType" value="${list2.boardType}" >${list2.codeName}</label>
				</c:forEach>

				<label><input id="seachBoardBtn" type="button" name="seachBoardBtn" value="조회"></label>
			</form>
		</td>
	</tr>
</table>	



</body>

 <!-- 카테고리별 조회 스크립트 -->
<script type="text/javascript">

	$j("#boardTypeAllCheckBox").click(function() {
	  var check = $j(this).is(":checked");
 	  if(check){
		  $j(".boardTypeCheckBox").prop("checked",true); 
 	  }else{
		  $j(this).prop('checked',false);
		  $j(".boardTypeCheckBox").prop("checked",false);
 	  }
	});
	
 	$j(".boardTypeCheckBox").click(function() {
		if($j(this).is(':checked')) 
			$j("#boardTypeAllCheckBox").prop('checked',false);
		else 
			$j(this).prop('checked',false);
	});
	
	$j("#seachBoardBtn").on("click",function(){
		if($j(".boardTypeCheckBox, #boardTypeAllCheckBox").is(':checked'))	
			$j("#frm").submit();
		else
			alert("조회할 카테고리를 선택하세요.");
	}); 

	
	

</script>
</html>