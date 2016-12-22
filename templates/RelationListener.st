RelationListener() ::= <<
$preamble()$

package $package()$;

import java.util.EventListener;

public interface RelationListener extends EventListener
{
	public void relationsChanged(RelationEvent relationEvent);
}
>>