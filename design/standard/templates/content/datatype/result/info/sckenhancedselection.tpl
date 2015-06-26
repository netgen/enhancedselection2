{if $attribute|get_class|eq( 'ezinformationcollectionattribute' )}
    {$attribute.data_text|wash}
{/if}
