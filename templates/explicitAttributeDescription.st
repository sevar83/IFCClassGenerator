explicitAttributeDescription(attribute) ::= <%
public static final $explicitAttributeTypeId(attribute)$ $publicAttributeName(attribute.id)$ = new $explicitAttributeTypeId(attribute)$("$privateAttributeName(attribute.id)$", $attribute.owner$.class, $attribute.demanded$);
%>