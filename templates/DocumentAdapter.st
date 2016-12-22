DocumentAdapter() ::= <<
$preamble()$

package $package()$;

import java.util.Collection;

public class DocumentAdapter implements DocumentListener
{
	/*@Override
	public void objectChanged(IfcClass object, DirectAttribute attribute, Object oldValue,	Object newValue)
	{
	}*/

	@Override
	public void objectsAdded(Collection<IfcClass> objects)
	{
	}

	@Override
	public void objectsRemoved(Collection<IfcClass> objects)
	{
	}

	@Override
	public void documentChanged()
	{
	}
}
>>