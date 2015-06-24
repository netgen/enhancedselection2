<?php

class SckEnhancedSelection extends eZPersistentObject
{
    /**
     * @param array $row
     */
    function __construct( $row )
    {
        parent::__construct( $row );
    }

    /**
     * @return array
     */
    static function definition()
    {
        return array(
            'fields' => array(
                'contentobject_attribute_id' => array(
                    'name' => 'ContentObjectAttributeID',
                    'datatype' => 'integer',
                    'default' => 0,
                    'required' => true
                ),
                'contentobject_attribute_version' => array(
                    'name' => 'ContentObjectAttributeVersion',
                    'datatype' => 'integer',
                    'default' => 0,
                    'required' => true
                ),
                'identifier' => array(
                    'name' => 'Identifier',
                    'datatype' => 'string',
                    'default' => '',
                    'required' => true
                )
            ),
            'keys' => array( 'contentobject_attribute_id', 'contentobject_attribute_version', 'identifier' ),
            'class_name' => 'SckEnhancedSelection',
            'sort' => array( 'contentobject_attribute_id' => 'asc', 'contentobject_attribute_version' => 'asc', 'identifier' => 'asc' ),
            'name' => 'sckenhancedselection'
        );
    }

    /**
     * @param int $contentObjectAttributeId
     * @param int $contentObjectAttributeVersion
     * @param string $identifier
     *
     * @return SckEnhancedSelection
     */
    static function fetch( $contentObjectAttributeId, $contentObjectAttributeVersion, $identifier )
    {
        return eZPersistentObject::fetchObject(
            self::definition(),
            null,
            array(
                'contentobject_attribute_id' => $contentObjectAttributeId,
                'contentobject_attribute_version' => $contentObjectAttributeVersion,
                'identifier' => $identifier
            )
        );
    }

    /**
     * @param int $contentObjectAttributeId
     * @param int $contentObjectAttributeVersion
     *
     * @return SckEnhancedSelection[]
     */
    static function fetchByAttribute( $contentObjectAttributeId, $contentObjectAttributeVersion )
    {
        $result = eZPersistentObject::fetchObjectList(
            self::definition(),
            null,
            array(
                'contentobject_attribute_id' => $contentObjectAttributeId,
                'contentobject_attribute_version' => $contentObjectAttributeVersion
            )
        );

        if ( is_array( $result ) && !empty( $result ) )
        {
            return $result;
        }

        return array();
    }

    /**
     * @param int $contentObjectAttributeId
     * @param int $contentObjectAttributeVersion
     *
     * @return int
     */
    static function countByAttribute( $contentObjectAttributeId, $contentObjectAttributeVersion )
    {
        return eZPersistentObject::count(
            self::definition(),
            array(
                'contentobject_attribute_id' => $contentObjectAttributeId,
                'contentobject_attribute_version' => $contentObjectAttributeVersion
            )
        );
    }

    /**
     * @param int $contentObjectAttributeId
     * @param int $contentObjectAttributeVersion
     */
    static function removeByAttribute( $contentObjectAttributeId, $contentObjectAttributeVersion = null )
    {
        $conditions = array(
            'contentobject_attribute_id' => $contentObjectAttributeId
        );

        if ( $contentObjectAttributeVersion !== null )
        {
            $conditions['contentobject_attribute_version'] = $contentObjectAttributeVersion;
        }

        eZPersistentObject::removeObject(
            self::definition(),
            $conditions
        );
    }
}
