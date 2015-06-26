{def $content = $attribute.content}
{def $class_content = $attribute.class_content}
{def $available_options = $class_content.options}

{if and( is_set( $class_content.db_options ), $class_content.db_options|count|gt( 0 ) )}
    {set available_options = $class_content.db_options}
{/if}

{set-block scope=root variable=pdf_text}
    {foreach $available_options as $option}
        {if $content|contains( $option.item.identifier )}
            {$option.item.name|wash}

            {delimiter}
                {cond( $class_content.delimiter|ne( "" ), $class_content.delimiter|wash, ", " )}
            {/delimiter}
        {/if}
    {/foreach}
{/set-block}

{pdf( text, $pdf_text|wash( pdf ) )}

{undef $content $class_content $available_options}
