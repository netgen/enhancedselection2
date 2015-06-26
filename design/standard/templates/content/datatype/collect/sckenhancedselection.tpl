{def $content = $attribute.content}
{def $class_content = $attribute.class_content}
{def $available_options = $class_content.options}
{def $id = $attribute.id}

{if and( is_set( $class_content.db_options ), $class_content.db_options|count|gt( 0 ) )}
    {set available_options = $class_content.db_options}
{/if}

<select name="ContentObjectAttribute_sckenhancedselection_selection_{$id|wash}[]"
    {if $class_content.is_multiselect}multiple="multiple"{/if}>

    {foreach $available_options as $option}
        <option value="{$option.identifier|wash}"
            {if $content|contains( $option.identifier )}selected="selected"{/if}>

            {$option.name|wash}
        </option>
    {/foreach}
</select>

{undef $content $class_content $available_options $id}
