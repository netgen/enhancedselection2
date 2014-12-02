<?php
class ezfSolrDocumentFieldEnhancedSelection2 extends ezfSolrDocumentFieldBase
{

    public static $subattributesDefinition = array(
        self::DEFAULT_SUBATTRIBUTE => 'lckeyword',
        'identifiers' => 'lckeyword',
        'values' => 'text'
     );

    /**
     * The name of the default subattribute. It will be used when
     * this field is requested with no subfield refinement.
     *
     * @see ezfSolrDocumentFieldDummyExample::$subattributesDefinition
     * @var string
     */
    const DEFAULT_SUBATTRIBUTE = 'options';


    /**
     * @see ezfSolrDocumentFieldBase::__construct()
     */
    function __construct( eZContentObjectAttribute $attribute )
    {
        parent::__construct( $attribute );
    }

    /**
     * @see ezfSolrDocumentFieldBase::getData()
     */
    public function getData()
    {
        $data = array();
        $contentClassAttribute = $this->ContentObjectAttribute->attribute( 'contentclass_attribute' );
        if($this->ContentObjectAttribute->attribute( 'has_content' ))
        {
            $xmlString = $contentClassAttribute->attribute('data_text5');
            $options = array();
            $dom = new DOMDocument();
            $dom->preserveWhiteSpace = false;
            $dom->loadXML( $xmlString );

            if( $dom )
            {
                $optionsNode = $dom->getElementsByTagName( 'options' )->item(0);
                $options['options'] = array();

                if( $optionsNode instanceof DomElement && $optionsNode->hasChildNodes()== true )
                {
                    $children = $optionsNode->childNodes;

                    foreach( $children as $child )
                    {
                        $options['options'][$child->getAttribute( 'identifier' )] = $child->getAttribute( 'name' );
                    }
                }
            }

            $content = $this->ContentObjectAttribute->content();

            $selectedValues = array();
            foreach($content as $identifier)
            {
                $selectedValues[$identifier] = $options['options'][$identifier];
            }

            $data[self::getFieldName( $contentClassAttribute )] = implode( ', ', $this->ContentObjectAttribute->content());
            $data[self::getFieldName( $contentClassAttribute, 'identifiers' )] = array_keys( $selectedValues );
            $data[self::getFieldName( $contentClassAttribute, 'values' )] = array_values($selectedValues);

        }
        return $data;
    }


    /**
     * @see ezfSolrDocumentFieldBase::getFieldName()
     */
    public static function getFieldName( eZContentClassAttribute $classAttribute, $subAttribute = null, $context = 'search' )
    {
        if ( $subAttribute and $subAttribute !== '' and array_key_exists( $subAttribute, self::$subattributesDefinition ) and $subAttribute != self::DEFAULT_SUBATTRIBUTE )
        {
            // A subattribute was passed
            return self::generateSubattributeFieldName( $classAttribute, $subAttribute, self::$subattributesDefinition[$subAttribute] );
        }
        else
        {
            // return the default field name here.
            return parent::generateAttributeFieldName( $classAttribute, self::$subattributesDefinition[self::DEFAULT_SUBATTRIBUTE] );
        }
    }

    /**
     * @see ezfSolrDocumentFieldBase::getFieldNameList()
     */
    public static function getFieldNameList( eZContentClassAttribute $classAttribute, $exclusiveTypeFilter = array() )
    {
        // Generate the list of subfield names.
        $subfields = array();

        //   Handle first the default subattribute
        $subattributesDefinition = self::$subattributesDefinition;
        if ( ! in_array( $subattributesDefinition[self::DEFAULT_SUBATTRIBUTE], $exclusiveTypeFilter ) )
        {
            $subfields[] = parent::generateAttributeFieldName( $classAttribute, $subattributesDefinition[self::DEFAULT_SUBATTRIBUTE] );
        }
        unset( $subattributesDefinition[self::DEFAULT_SUBATTRIBUTE] );

        //   Then handle all other subattributes
        foreach ( $subattributesDefinition as $name => $type )
        {
            if ( empty( $exclusiveTypeFilter ) or ! in_array( $type, $exclusiveTypeFilter ) )
            {
                $subfields[] = self::generateSubattributeFieldName( $classAttribute, $name, $type );
            }
        }
        return $subfields;
    }

    /**
     * @see ezfSolrDocumentFieldBase::getClassAttributeType()
     */
    static function getClassAttributeType( eZContentClassAttribute $classAttribute, $subAttribute = null, $context = 'search' )
    {
        if ( $subAttribute and $subAttribute !== '' and array_key_exists( $subAttribute, self::$subattributesDefinition ) )
        {
            // If a subattribute's type is being explicitly requested :
            return self::$subattributesDefinition[$subAttribute];
        }
        else
        {
            // If no subattribute is passed, return the default subattribute's type :
            return self::$subattributesDefinition[self::DEFAULT_SUBATTRIBUTE];
        }
    }
}
