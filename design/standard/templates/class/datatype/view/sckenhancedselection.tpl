{def $content = $class_attribute.content}
{def $i18n_context = "extension/enhancedselection2/class/view"}

<label>{"Option list"|i18n( $i18n_context )}:</label>
<table class="list" cellspacing="0">
    <tr>
        <th style="width: 1%;">&nbsp;</th>
        <th>{"Name"|i18n( $i18n_context )}</th>
        <th>{"Identifier"|i18n( $i18n_context )}</th>
    </tr>

    {foreach $content.options as $option}
        <tr>
            <td>{$option.number|wash}.</td>
            <td>{first_set( $option.name|wash, "&nbsp;" )}</td>
            <td>{first_set( $option.identifier|wash, "&nbsp;" )}</td>
        </tr>
    {/foreach}
</table>

<div class="block">
    <div class="element">
        <label>{"Multiple choice"|i18n( $i18n_context )}:</label>
        <p>{cond( $content.is_multiselect, "Yes"|i18n( $i18n_context ), "No"|i18n( $i18n_context ) )}</p>
    </div>

    <div class="element">
        <label>{"Delimiter"|i18n( $i18n_context )}:</label>
        <p style="white-space: pre;">'{$content.delimiter|wash}'</p>
    </div>

    <div class="break"></div>
</div>

<div class="block">
    <label>{"Database query"|i18n( $i18n_context )}:</label>
    <p>{$content.query|wash|nl2br}</p>
</div>

{undef $content $i18n_context}
