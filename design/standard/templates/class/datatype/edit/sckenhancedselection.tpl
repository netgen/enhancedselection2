{def $id = $class_attribute.id}
{def $content = $class_attribute.content}
{def $i18n_context = "extension/enhancedselection2/class/edit"}

<fieldset>
    <legend>{"Option list"|i18n( $i18n_context )}</legend>

    {if $content.options|count|gt( 0 )}
        <table class="list" cellspacing="0">
            <tr>
                <th style="width: 1%;">&nbsp;</th>
                <th>{"Name"|i18n( $i18n_context )}</th>
                <th>{"Identifier"|i18n( $i18n_context )}</th>
                <th>{"Priority"|i18n( $i18n_context )}</th>
                <th style="width: 1%;">&nbsp;</th>
            </tr>

            {foreach $content.options as $option_row}
                <tr>
                    <td>
                        <input type="checkbox"
                            name="ContentClass_sckenhancedselection_remove_{$id|wash}[]"
                            value="{$option_row.index|wash}" />
                    </td>

                    <td>
                        <input type="hidden"
                            name="ContentClass_sckenhancedselection_id_{$id|wash}[]"
                            value="{$option_row.item.id|wash}" />

                        <input type="text"
                            name="ContentClass_sckenhancedselection_name_{$id|wash}[{$option_row.item.id|wash}]"
                            value="{$option_row.item.name|wash}" />
                    </td>

                    <td>
                        <input type="text"
                            name="ContentClass_sckenhancedselection_identifier_{$id|wash}[{$option_row.item.id|wash}]"
                            value="{$option_row.item.identifier|wash}" />
                    </td>

                    <td>
                        <input type="text"
                            name="ContentClass_sckenhancedselection_priority_{$id|wash}[{$option_row.item.id|wash}]"
                            value="{$option_row.item.priority|wash}"
                            size="3" />
                    </td>

                    <td>
                        <div style="white-space: nowrap;">
                            {def $up_enabled = $option_row.number|eq( 1 )|not}
                            {def $down_enabled = $option_row.number|eq( count( $content.options ) )|not}
                            {def $up_image = cond( $up_enabled, "button-move_up.gif", "button-move_up-disabled.gif" )}
                            {def $down_image = cond( $down_enabled, "button-move_down.gif", "button-move_down-disabled.gif" )}

                            {* Moving the first option up and the last option down doesn't make sense *}
                            <input type="image"
                                src={$up_image|ezimage}
                                name="CustomActionButton[{$id|wash}_move_up]"
                                value="{$option_row.index|wash}"
                                title="{'Move up'|i18n( $i18n_context )}"
                                {if $up_enabled|not}disabled="disabled"{/if} />

                            <input type="image"
                                src={$down_image|ezimage}
                                name="CustomActionButton[{$id|wash}_move_down]"
                                value="{$option_row.index|wash}"
                                title="{'Move down'|i18n( $i18n_context )}"
                                {if $down_enabled|not}disabled="disabled"{/if} />

                            {undef $up_enabled $down_enabled $up_image $down_image}
                        </div>
                    </td>
                </tr>
            {/foreach}
        </table>
    {/if}

    <div class="block">
        <input type="submit"
            class="button"
            value="{'New option'|i18n( $i18n_context )}"
            name="CustomActionButton[{$id|wash}_new_option]" />

        <input type="submit"
            {if $content.options|count|gt( 0 )}class="button"{else}disabled="disabled"{/if}
            value="{'Remove selected option(s)'|i18n( $i18n_context )}"
            name="CustomActionButton[{$id|wash}_remove_optionlist]" />

        {* Sorting 1 option doesn't make sense *}
        <input type="submit"
            {if $content.options|count|gt( 1 )}class="button"{else}disabled="disabled"{/if}
            value="{'Sort options'|i18n( $i18n_context )}"
            name="CustomActionButton[{$id|wash}_sort_optionlist]" />

        <select {if $content.options|count|le( 1 )}disabled="disabled"{/if} name="ContentClass_sckenhancedselection_sort_order_{$id|wash}">
            <option value="alpha_asc">{"A-Z"|i18n( $i18n_context )}</option>
            <option value="alpha_desc">{"Z-A"|i18n( $i18n_context )}</option>
            <option value="prior_asc">{"Priority"|i18n( $i18n_context )}</option>
        </select>
    </div>
</fieldset>

<div class="block">
    <div class="element">
        <label>{"Multiple choice"|i18n( $i18n_context )}:</label>
        <input type="checkbox"
            name="ContentClass_sckenhancedselection_multi_{$id|wash}"
            {if $content.is_multiselect}checked="checked"{/if} />
    </div>

    <div class="element">
        <label>{"Delimiter"|i18n( $i18n_context )}:</label>
        <input type="text"
            name="ContentClass_sckenhancedselection_delimiter_{$id|wash}"
            value="{$content.delimiter|wash}"
            size="5" />
    </div>

    <div class="break"></div>
</div>

<div class="block">
    <label>{"Database query"|i18n( $i18n_context )}:</label>

    <textarea rows="5"
        cols="80"
        name="ContentClass_sckenhancedselection_query_{$id|wash}">{$content.query|wash}</textarea>
</div>

{undef $id $content $i18n_context}
