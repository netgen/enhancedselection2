{def $content = $attribute.content}
{def $class_content = $attribute.class_content}
{def $i18n_context = "extension/enhancedselection2/object/view"}
{def $available_options = $class_content.options}

{if and( is_set( $class_content.db_options ), $class_content.db_options|count|gt( 0 ) )}
    {set available_options = $class_content.db_options}
{/if}

{foreach $available_options as $option}
    {if $content|contains( $option.identifier )}
        {$option.name|wash}

        {delimiter}
            {cond( $class_content.delimiter|ne( "" ), $class_content.delimiter|wash, ", " )}
        {/delimiter}
    {/if}
{/foreach}

{undef $content $class_content $i18n_context $available_options}
