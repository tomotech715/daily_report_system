<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="constants.ForwardConst" %>
<%@ page import="constants.AttributeConst" %>

<c:set var="actRep" value="${ForwardConst.ACT_REP.getValue()}" />
<c:set var="commIdx" value="${ForwardConst.CMD_INDEX.getValue()}" />
<c:set var="commEdt" value="${ForwardConst.CMD_EDIT.getValue()}" />
<c:set var="empAdf" value="${AttributeConst.ROLE_MANAGER.getValue()}" />
<c:set var="repAp"   value="${ForwardConst.CMD_APPROVAL.getValue()}" />
<c:set var="repApCan" value="${ForwardConst.CMD_APPROVALCANCEL.getValue()}" />


<c:import url="/WEB-INF/views/layout/app.jsp">
    <c:param name="content">

        <h2>日報 詳細ページ</h2>
        <c:if test="${report.approvalFlag == AttributeConst.AP_FLAG_TRUE.getIntegerValue()}"><b style="color:red;">承認済み</b></c:if>

        <table>
            <tbody>
                <tr>
                    <th>氏名</th>
                    <td><c:out value="${report.employee.name}" /></td>
                </tr>
                <tr>
                    <th>日付</th>
                    <fmt:parseDate value="${report.reportDate}" pattern="yyyy-MM-dd"
                        var="reportDay" type="date" />
                    <td><fmt:formatDate value='${reportDay}' pattern='yyyy-MM-dd' /></td>
                </tr>
                <tr>
                    <th>内容</th>
                    <td><pre><c:out value="${report.content}" /></pre></td>
                </tr>
                <tr>
                    <th>登録日時</th>
                    <fmt:parseDate value="${report.createdAt}"
                        pattern="yyyy-MM-dd'T'HH:mm:ss" var="createDay" type="date" />
                    <td><fmt:formatDate value="${createDay}"
                            pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
                <tr>
                    <th>更新日時</th>
                    <fmt:parseDate value="${report.updatedAt}"
                        pattern="yyyy-MM-dd'T'HH:mm:ss" var="updateDay" type="date" />
                    <td><fmt:formatDate value="${updateDay}"
                            pattern="yyyy-MM-dd HH:mm:ss" /></td>
                </tr>
            </tbody>
        </table>

        <c:if test="${sessionScope.login_employee.id == report.employee.id}">
            <p>
                <a
                    href="<c:url value='?action=${actRep}&command=${commEdt}&id=${report.id}' />">この日報を編集する</a>
            </p>
        </c:if>


        <c:if test="${sessionScope.login_employee.adminFlag == AttributeConst.ROLE_MANAGER.getIntegerValue() && report.approvalFlag == AttributeConst.AP_FLAG_FALSE.getIntegerValue()}">
            <p>
                <a href="#" onclick="confirmApproval();">この日報を承認する</a>
            </p>
        </c:if>
        <form method="POST"
            action="<c:url value='?action=${actRep}&command=${repAp}' />">
            <input type="hidden" name="${AttributeConst.REP_ID.getValue()}" value="${report.id}" />
            <input type="hidden" name="${AttributeConst.TOKEN.getValue()}" value="${_token}" />
        </form>
        <script>
            function confirmApproval() {
                if (confirm("承認しますか？")) {
                    document.forms[0].submit();
                }
            }
        </script>


        <c:if test="${sessionScope.login_employee.adminFlag == AttributeConst.ROLE_MANAGER.getIntegerValue() && report.approvalFlag == AttributeConst.AP_FLAG_TRUE.getIntegerValue()}">
            <p>
                <a href="#" onclick="confirmApprovalCancel();">日報の承認を取り消す</a>
            </p>
        </c:if>
        <form method="POST"
            action="<c:url value='?action=${actRep}&command=${repApCan}' />">
            <input type="hidden" name="${AttributeConst.REP_ID.getValue()}" value="${report.id}" />
            <input type="hidden" name="${AttributeConst.TOKEN.getValue()}" value="${_token}" />
        </form>
        <script>
            function confirmApprovalCancel() {
                if (confirm("承認を取り消しますか？")) {
                    document.forms[1].submit();
                }
            }
        </script>

        <p>
            <a href="<c:url value='?action=${actRep}&command=${commIdx}' />">一覧に戻る</a>
        </p>
    </c:param>
</c:import>


