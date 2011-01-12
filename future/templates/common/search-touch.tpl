{extends file="findExtends:common/search.tpl"}

{block name="form"}
  {if !$insideForm}
    <div class="nonfocal" id="searchformcontainer">
      <form method="get" action="{$searchPage|default:'search'}.php">
  {/if}
      {if $placeholder}
        {if $emphasized|default:$isModuleHome}<h3>{else}<strong>{/if}
          {$placeholder}:
        {if $emphasized|default:$isModuleHome}</h3>{else}</strong><br/>{/if}
      {/if}
      <table cellpadding="0" cellspacing="0" border="0" style="width:100%">
        <tr>
          <td width="70%">
            <input class="forminput" type="text" id="{$inputName|default:'filter'}" name="{$inputName|default:'filter'}" value="{$searchTerms|escape}" />
          </td>
          <td width="30%">
            {block name="formSubmit"}
              <input type="submit" value="Search" class="submitbutton" />
            {/block}
          </td>
        </tr>
        {if isset($additionalInputs)}
          <tr>
            <td colspan="2">
              {$additionalInputs}
            </td>
          </tr>
        {/if}
      </table>
      {$hiddenArgHTML}
      {$tipHTML}
      {$inlineErrorHTML}
      
  {if !$insideForm}
      </form>
    </div>
  {/if}
{/block}
