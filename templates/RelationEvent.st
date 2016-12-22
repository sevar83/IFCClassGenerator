RelationEvent() ::= <<
$preamble()$

package $package()$;

import java.util.Collection;
import java.util.EventObject;


public class RelationEvent extends EventObject
{
	public enum Type { ESTABLISHED, SEVERED };
	
	private final Type type;
	private final IfcRelationship relationship;
	private final IfcClass relatingObject;
	private final Collection<IfcClass> relatedObjects;
	
	public RelationEvent(Object source, Type type, IfcRelationship relationship, IfcClass relatingObject, Collection<IfcClass> relatedObjects)
	{
		super(source);
		
		if (relationship == null)
	    throw new IllegalArgumentException("null relationship");
		if (relatedObjects == null)
			throw new IllegalArgumentException("null relatedObjects");
		
		this.type = type;
		this.relationship = relationship;
		this.relatingObject = relatingObject;
		this.relatedObjects = relatedObjects;
	}

	public Type getType()
	{
		return this.type;
	}
	
	public IfcRelationship getRelationship()
	{
		return this.relationship;
	}

	public IfcClass getRelatingObject()
	{
		return this.relatingObject;
	}
	
	public Collection<IfcClass> getRelatedObjects()
	{
		return this.relatedObjects;
	}
	
	public boolean matches(Class<IfcRelationship> relationshipClass, Class<IfcClass> relatingClass)
	{
		return this.relationship.getClass().isAssignableFrom(relationshipClass) &&
					 this.relatingObject.getClass().isAssignableFrom(relatingClass);
	}
}
>>