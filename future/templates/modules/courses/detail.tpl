{include file="findInclude:common/header.tpl"}

{$tabBodies = array()}
{capture name="infoPane" assign="infoPane"}
  {block name="infoPane"}
    <ul class="nav">
      {if !count($times) && !count($infoItems)}
        <li> No detailed information to display </li>
      {else}
        {foreach $times as $time}
          <li>
            {if isset($time['location']) && isset($time['url'])}
              <a class="map" href="{$time['url']}">
                {$time['days']} {$time['time']} ({$time['location']})
              </a>
            {else}
              {$time['days']} {$time['time']}
            {/if}
          </li>
        {/foreach}
        {foreach $infoItems as $item}
          <li>
            <h3>{$item['header']}</h3>
            <p>{$item['content']}</p>
          </li>
        {/foreach}
      {/if}
    </ul>
  {/block}
{/capture}
{$tabBodies['info'] = $infoPane}

{capture name="staffPane" assign="staffPane"}
  {block name="staffPane"}
    <ul class="nav">
        <li><h3>Instructor(s):</h3></li>
        {foreach $staff['instructors'] as $instructor}
          <li><a href="{$instructor['url']}" class="people">{$instructor['title']}</a></li>
        {/foreach}
        
        {if count($staff['tas'])}
          <li></li>
          <li><h3>TAs:</h3></li>
          {foreach $staff['tas'] as $ta}
            <li><a href="{$ta['url']}" class="people">{$ta['title']}</a></li>
          {/foreach}
        {/if}
        <li></li>
    </ul>
  {/block}
{/capture}
{$tabBodies['staff'] = $staffPane}

<a name="scrolldown"></a>		
<div class="focal shaded">

  {block name="courseHeader"}
    <a id="myclasses" class="{if $isInMyClasses}ms_on{else}ms_off{/if}" onclick="toggleMyClasses(this, '{$classId} {$term}')"></a>
    <h2>{$className}: {$classTitle}</h2>
    <p class="address">{$term}{if strlen($classUrl)} | <a href="{$classUrl}" target="_new">Course Website</a>{/if}</p>
  {/block}

  {include file="findInclude:common/tabs.tpl" tabBodies=$tabBodies}
</div>

{include file="findInclude:common/footer.tpl"}
