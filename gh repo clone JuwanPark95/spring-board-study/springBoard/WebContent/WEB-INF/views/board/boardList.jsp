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
						        <a>�Ϲ�</a>
						    </c:when>
						    <c:when test="${list.boardType eq 'a02'}">
						        <a>Q&A</a>
						    </c:when>
						    <c:when test="${list.boardType eq 'a03'}">
						        <a>�͸�</a>
						    </c:when>
						    <c:when test="${list.boardType eq 'a04'}">
						        <a>����</a>
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
			<a href ="/board/boardWrite.do">�۾���</a>
		</td>
	</tr>
	<tr>
		<td align="left">
			<form action="/board/boardSeachList.do" id="frm" method="post">
				<label><input id="boardTypeAllCheckBox" type="checkbox">��ü</label>

				<c:forEach items="${boardTypeList}" var="list2">
					<label><input class="boardTypeCheckBox" type="checkbox" name="boardType" value="${list2.boardType}" >${list2.codeName}</label>
				</c:forEach>

				<label><input id="seachBoardBtn" type="button" name="seachBoardBtn" value="��ȸ"></label>
			</form>
		</td>
	</tr>
</table>	



</body>

 <!-- ī�װ��� ��ȸ ��ũ��Ʈ -->
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
			alert("��ȸ�� ī�װ��� �����ϼ���.");
	}); 

	
	

</script>
</html>