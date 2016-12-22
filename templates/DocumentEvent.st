DocumentEvent() ::= <<
$preamble()$

package $package()$;

import java.util.Collection;

public class DocumentEvent
{
	public static final int DOCUMENT_CHANGED = 0;
	public static final int OBJECT_CHANGED = 1;
	public static final int OBJECTS_ADDED = 2;
	public static final int OBJECTS_REMOVED = 3;	
	private int type = -1;
	
	private IfcClass object;
	private Collection<IfcClass> objects = null;	
	
	public DocumentEvent(int type)
	{
		this.type = type;
	}

	public DocumentEvent(int type, Collection<IfcClass> objects)
	{
		this.type = type;
		this.objects = objects;
	}

	public DocumentEvent(int type, IfcClass object)
	{
		this.type = type;
		this.object = object;
	}

	public int getType() 
	{
		return type;
	}
	
	public IfcClass getObject() 
	{
		return this.object;
	}

	public Collection<IfcClass> getObjects() 
	{
		return objects;
	}
}
>>