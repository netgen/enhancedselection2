{def $content = $attribute.content}
{def $class_content = $attribute.class_content}
{def $id = $attribute.id}
{def $i18n_context = "extension/enhancedselection2/object/view"}
{def $available_options = $class_content.options}

{if and( is_set( $class_content.db_options ), $class_content.db_options|count|gt( 0 ) )}
    {set available_options = $class_content.db_options}
{/if}

<select name="ContentObjectAttribute_sckenhancedselection_selection_{$id|wash}[]"
    {if $class_content.is_multiselect}multiple="multiple"{/if}>

    {foreach $available_options as $option}
        <option value="{$option.item.identifier|wash}"
            {if $content|contains( $option.item.identifier )}selected="selected"{/if}>

            {$option.item.name|wash}
        </option>
    {/foreach}
</select>

{undef $content $class_content $id $i18n_context $available_options}
