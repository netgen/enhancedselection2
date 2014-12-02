<?php
class ezfSolrDocumentFieldEnhancedSelection2 extends ezfSolrDocumentFieldBase
{
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
            $data[self::getFieldName( $contentClassAttribute )] = implode( ',', $this->ContentObjectAttribute->attribute( 'content' ) );
        }
        return $data;
    }
}
