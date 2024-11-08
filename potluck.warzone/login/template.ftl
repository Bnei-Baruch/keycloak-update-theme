<#import "field.ftl" as field>
<#import "footer.ftl" as loginFooter>
<#import "alert.ftl" as loginAlert>
<#macro username>
  <div></div>
  <#assign label>
    <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
  </#assign>
  <@field.group name="username" label=label>
    <div class="flex item-center mt-2">
      <div class="w-full">
          <input class="px-4 py-2.5 bg-white text-gray-800 rounded-lg outline-none border-purple-300 border-dashed ring-1 ring-offset-2 ring-purple-500 w-full focus:outline-none focus:border-purple-300 focus:border-dashed focus:ring-1 focus:ring-offset-2 focus:ring-purple-500" id="kc-attempted-username" value="${auth.attemptedUsername}" readonly>
      </div>
      <div class="ml-4">
        <button id="reset-login" class="py-2.5 px-4 rounded-lg border-2 border-purple-400 text-center text-purple-600 w-max" type="button" 
              aria-label="${msg('restartLoginTooltip')}" onclick="location.href='${url.loginRestartFlowUrl}'">
            <i class="fa-sync-alt fas" aria-hidden="true"></i>
            <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
        </button>
      </div>
    </@field.group>
</#macro>

<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html class="${properties.kcHtmlClass!}"<#if realm.internationalizationEnabled> lang="${locale.currentLanguageTag}"</#if>>

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.svg" />
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" type="text/css" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" type="text/css" />
        </#list>
    </#if>
    <script type="importmap">
        {
            "imports": {
                "rfc4648": "${url.resourcesCommonPath}/vendor/rfc4648/rfc4648.js"
            }
        }
    </script>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
    <script type="module">
        import { checkCookiesAndSetTimer } from "${url.resourcesPath}/js/authChecker.js";
        checkCookiesAndSetTimer("${url.ssoLoginInOtherTabsUrl?no_esc}");
    </script>
</head>

<body id="keycloak-bg-custom" class="bg-white">
  <div class="grid lg:grid-cols-2 h-full w-full">
    <div class="text-gray-800 content-end pb-24 hidden lg:block bg-[url(../img/hero.webp)] bg-cover object-cover">
      <h1 class="text-center text-4xl font-semibold text-white">${msg("companyTagLineTitle")}</h1>
    </div>
    <div class="p-4 w-full flex flex-col justify-center bg-[url(../img/hero-pattern.svg)]">
      <main class="max-w-md w-full mx-auto">
        <header id="kc-header-custom" class="mb-10 font-semibold">
          <p class="text-purple-800 text-2xl">${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}</p>
        </header>
        <div class="text-slate-700">
          <h1 class="text-2xl font-medium">Auth</h1>
          <h2 class="text-purple-500" id="kc-page-title-custom"><#nested "header"></h1>
          <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
              <div class="w-full flex justify-end">
                <select
                  class="px-2 py-1 text-sm bg-white text-gray-800 rounded-md border border-gray-300 focus:outline-none focus:border-purple-300 focus:border-dashed focus:ring-1 focus:ring-offset-2 focus:ring-purple-500 w-max"
                  aria-label="${msg("languages")}"
                  id="login-select-toggle"
                  onchange="if (this.value) window.location.href=this.value"
                >
                  <#list locale.supported?sort_by("label") as l>
                    <option
                      value="${l.url}"
                      ${(l.languageTag == locale.currentLanguageTag)?then('selected','')}
                    >
                      ${l.label}
                    </option>
                  </#list>
                </select>
            </div>
          </#if>
        </div>
        <div id="main-body" class="${properties.kcLoginMainBody!}">
          <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
              <#if displayRequiredFields>
                  <div class="${properties.kcContentWrapperClass!} hidden">
                      <div class="${properties.kcLabelWrapperClass!} subtitle text-gray-800">
                          <span class="${properties.kcInputHelperTextItemTextClass!}">
                            <span class="${properties.kcInputRequiredClass!}">*</span> ${msg("requiredFields")}
                          </span>
                      </div>
                  </div>
              </#if>
          <#else>
              <#if displayRequiredFields>
                  <div class="${properties.kcContentWrapperClass!} hidden">
                      <div class="${properties.kcLabelWrapperClass!} subtitle text-gray-800">
                          <span class="${properties.kcInputHelperTextItemTextClass!}">
                            <span class="${properties.kcInputRequiredClass!}">*</span> ${msg("requiredFields")}
                          </span>
                      </div>
                      <div class="${properties.kcFormClass} ${properties.kcContentWrapperClass}">
                          <#nested "show-username">
                          <@username />
                      </div>
                  </div>
              <#else>
                  <div class="${properties.kcFormClass} ${properties.kcContentWrapperClass}">
                    <#nested "show-username">
                    <@username />
                  </div>
              </#if>
          </#if>

          <#-- App-initiated actions should not see warning messages about the need to complete the action -->
          <#-- during login.                                                                               -->
          <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
              <@loginAlert.alert message=message />
          </#if>
          
          <div class="my-5"><#nested "form"></div>

          <#if auth?has_content && auth.showTryAnotherWayLink()>
            <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post" novalidate="novalidate">
                <input type="hidden" name="tryAnotherWay" value="on"/>
                <a id="try-another-way" href="javascript:document.forms['kc-select-try-another-way-form'].submit()"
                    class="${properties.kcButtonSecondaryClass} ${properties.kcButtonBlockClass} ${properties.kcMarginTopClass}">
                      ${kcSanitize(msg("doTryAnotherWay"))?no_esc}
                </a>
            </form>
          </#if>
          <#if displayInfo>
            <div id="kc-info" class="${properties.kcSignUpClass!}">
                <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                    <#nested "info">
                </div>
            </div>
          </#if>
        </div>
        <div class="pf-v5-c-login__main-footer">
          <#nested "socialProviders">
        </div>
      </main>
      <@loginFooter.content/>
    </div>
  </div>
</body>
</html>
</#macro>
