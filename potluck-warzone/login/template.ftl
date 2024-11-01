<#import "field.ftl" as field>
<#macro username>
  <div></div>
  <#assign label>
    <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
  </#assign>
  <@field.group name="username" label=label>
    <div class="flex item-center gap-4 mt-2">
      <div class="w-full">
        <span class="w-full">
          <input class="px-4 py-2.5 bg-white text-gray-800 rounded-lg outline-none border-purple-300 border-dashed ring-1 ring-offset-2 ring-purple-500 w-full focus:outline-none focus:border-purple-300 focus:border-dashed focus:ring-1 focus:ring-offset-2 focus:ring-purple-500" id="kc-attempted-username" value="${auth.attemptedUsername}" readonly>
        </span>
      </div>
      <div class="${properties.kcInputGroupItemClass}">
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
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
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

        checkCookiesAndSetTimer(
            "${url.ssoLoginInOtherTabsUrl?no_esc}"
        );

        const DARK_MODE_CLASS = "pf-v5-theme-dark";
        const mediaQuery =window.matchMedia("(prefers-color-scheme: dark)");
        updateDarkMode(mediaQuery.matches);
        mediaQuery.addEventListener("change", (event) =>
          updateDarkMode(event.matches),
        );
        function updateDarkMode(isEnabled) {
          const { classList } = document.documentElement;
          if (isEnabled) {
            classList.add(DARK_MODE_CLASS);
          } else {
            classList.remove(DARK_MODE_CLASS);
          }
        }
    </script>
</head>

<body id="keycloak-bg-custom" class="bg-white">

<div class="grid lg:grid-cols-2 h-full w-full">
  <div class="text-gray-800 content-end pb-24 hidden lg:block bg-[url(../img/hero.webp)] bg-cover bg-no-repeat">
    <h1 class="text-center text-4xl font-semibold text-white">Fairness For You</h1>
  </div>
  <div class="p-4 w-full flex flex-col justify-center bg-[url(../img/hero-pattern.svg)]">
    <main class="max-w-md w-full mx-auto">
      <header id="kc-header-custom" class="mb-10 font-semibold">
        <p class="text-gray-800 text-4xl">${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}</p>
      </header>
      <div class="text-slate-700">
        <h1 class="text-2xl font-medium">Auth</h1>
        <h2 class="text-purple-500" id="kc-page-title-custom"><#nested "header"></h1>
        <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
          <div class="">
            <div class="">
              <select
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
              <span class="${properties.kcFormControlUtilClass}">
                <span class="${properties.kcFormControlToggleIcon!}">
                  <svg
                    class="pf-v5-svg"
                    viewBox="0 0 320 512"
                    fill="currentColor"
                    aria-hidden="true"
                    role="img"
                    width="1em"
                    height="1em"
                  >
                    <path
                      d="M31.3 192h257.3c17.8 0 26.7 21.5 14.1 34.1L174.1 354.8c-7.8 7.8-20.5 7.8-28.3 0L17.2 226.1C4.6 213.5 13.5 192 31.3 192z"
                    >
                    </path>
                  </svg>
                </span>
              </span>
            </div>
          </div>
        </#if>
      </div>
      <div class="${properties.kcLoginMainBody!}">
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
            <div class="alert-${message.type}">
                <#if message.type = 'success'>
                  <span class="text-green-500">
                    <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" aria-hidden="true" viewBox="0 0 24 24"><path fill="currentColor" d="m10.6 16.6l7.05-7.05l-1.4-1.4l-5.65 5.65l-2.85-2.85l-1.4 1.4zM12 22q-2.075 0-3.9-.788t-3.175-2.137T2.788 15.9T2 12t.788-3.9t2.137-3.175T8.1 2.788T12 2t3.9.788t3.175 2.137T21.213 8.1T22 12t-.788 3.9t-2.137 3.175t-3.175 2.138T12 22"/></svg>
                  </span>
                </#if>
                <#if message.type = 'warning'>
                  <span class="text-yellow-500">
                      <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" aria-hidden="true" viewBox="0 0 24 24"><path fill="currentColor" d="M12.884 2.532c-.346-.654-1.422-.654-1.768 0l-9 17A1 1 0 0 0 3 21h18a.998.998 0 0 0 .883-1.467zM13 18h-2v-2h2zm-2-4V9h2l.001 5z"/></svg>
                  </span>
                </#if>
                <#if message.type = 'info'>
                  <span class="text-blue-500">
                      <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" aria-hidden="true" viewBox="0 0 24 24"><path fill="currentColor" d="M11 17h2v-6h-2zm1-8q.425 0 .713-.288T13 8t-.288-.712T12 7t-.712.288T11 8t.288.713T12 9m0 13q-2.075 0-3.9-.788t-3.175-2.137T2.788 15.9T2 12t.788-3.9t2.137-3.175T8.1 2.788T12 2t3.9.788t3.175 2.137T21.213 8.1T22 12t-.788 3.9t-2.137 3.175t-3.175 2.138T12 22"/></svg>
                  </span>
                </#if>
                <#if message.type = 'error'>
                  <span class="text-red-500">
                      <svg xmlns="http://www.w3.org/2000/svg" class="w-5 h-5" aria-hidden="true" viewBox="0 0 24 24"><path d="M16.707 2.293A.996.996 0 0 0 16 2H8a.996.996 0 0 0-.707.293l-5 5A.996.996 0 0 0 2 8v8c0 .266.105.52.293.707l5 5A.996.996 0 0 0 8 22h8c.266 0 .52-.105.707-.293l5-5A.996.996 0 0 0 22 16V8a.996.996 0 0 0-.293-.707l-5-5zM13 17h-2v-2h2v2zm0-4h-2V7h2v6z" fill="currentColor"/></svg>
                  </span>
                </#if>
                <span class="text-sm">${kcSanitize(message.summary)?no_esc}</span>
            </div>
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
  </div>
</div>
</body>
</html>
</#macro>
