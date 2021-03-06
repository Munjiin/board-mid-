<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">List</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Board List</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<div class="table-responsive">
					<table class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>TNO</th>
								<th>TITLE</th>
								<th>WRITER</th>
								<th>REGDATE</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="board">
								<tr>
									<td><c:out value="${board.bno}" /></td>
									<td><a href='${board.bno}' class='board'><c:out
												value="${board.title}" /></a></td>
									<td><c:out value="${board.writer}" /></td>
									<td><fmt:formatDate value="${board.regdate}"
											pattern="yyyy-MM-dd HH:mm:ss " /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- /.table-responsive -->
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<button type="button" class="btn btn-outline btn-primary btn-lg"
		onclick="location.href='/board/register'">글쓰기</button>

	<!-- /.col-lg-6 -->
	<div class="dataTables_paginate paging_simple_numbers"
		id="dataTables-example_paginate">
		<ul class="pagination">
			<c:if test="${pageObj.prev}">
				<li class="paginate_button previous"
					aria-controls="dataTables-example" tabindex="0"
					id="dataTables-example_previous"><a href="${pageObj.start -1}">Previous</a></li>
			</c:if>
			<c:forEach begin="${pageObj.start}" end="${pageObj.end}" var="num">
				<li class="paginate_button" data-page='${num}'
					aria-controls="dataTables-example" tabindex="0"><a
					href="${num }"><c:out value="${num}" /></a></li>
			</c:forEach>
			<c:if test="${pageObj.next}">
				<li class="paginate_button next" aria-controls="dataTables-example"
					tabindex="0" id="dataTables-example_next"><a
					href="${pageObj.end +1}">Next</a></li>
			</c:if>
		</ul>
	</div>
</div>

<form id='actionForm'>
	<input type='hidden' name='page' id='page' value='${pageObj.page}'>
</form>

</div>
<!-- /#page-wrapper -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Modal title</h4>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>

<%@include file="../includes/footer.jsp"%>


<script>
	$(document)
			.ready(
					function() {

						var actionForm = $("#actionForm")
						var pageNum = $
						{
							pageObj.page
						}
						;

						history.replaceState({}, null, null);

						$(".board")
								.on(
										"click",
										function(e) {
											e.preventDefault();
											var bno = $(this).attr("href")
											actionForm
													.append("<input type='hidden' name='bno' value='"+bno+"'>");
											actionForm.attr("action",
													"/board/read").attr(
													"method", "get").submit();
										});

						$('.pagination li[data-page=' + pageNum + ']')
								.addClass("active"); // 속성으로 찾을 수 있다

						$('.pagination li a').on("click", function(e) {
							e.preventDefault(); //기본동작 막기
							var target = $(this).attr("href");//페이지 번호
							// console.log(target);

							$("#page").val(target);
							actionForm.attr("action", "/board/list").submit();

						});

						var msg = $("#myModal");
						var result = '<c:out value="${result}"/>';

						if (result === '' || history.state) {
							return;
						}

						if (result === 'SUCCESS') {
							$(".modal-body").html("글 등록에 성공하였습니다.");
							msg.modal("show");

						}
					});
</script>
</body>

</html>