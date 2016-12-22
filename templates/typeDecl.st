typeDecl(type) ::= <%
$if(type.aggregation)$
	$type.id$<$typeDecl(type.baseType.type)$>
$else$
	$type.id$
$endif$
%>