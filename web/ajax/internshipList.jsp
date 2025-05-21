<%-- 
    Document   : internshipList
    Created on : May 9, 2025, 10:03:23?AM
    Author     : RasinduPerera
--%>

<%@ page import="dao.InternshipDAO, java.util.List, model.Internship" %>
<%
    try {
        List<Internship> internships = new InternshipDAO().getAllInternships();
        for(Internship i : internships) {
%>
    <option value="<%=i.getId()%>"><%=i.getTitle()%> - Deadline: <%=i.getDeadline()%></option>
<% 
        }
    } catch(Exception e) {
%>
    <option value="">Error loading internships</option>
<%
    }
%>
