RelationOneToMany() ::= <<
$preamble()$

package $package()$;

import java.util.Collection;


/**
 * Relation 1-to-Many
 * 
 * @author Svetlozar Kostadinov
 *
 * @param <RELATING> Type of the relating object
 * @param <RELATED> Type of the related object
 */
public interface RelationOneToMany<RELATING extends IfcClass, RELATED extends IfcClass> extends Relation<RELATING>
{
	public Collection<RELATED> getRelatedObjects();
}
>>