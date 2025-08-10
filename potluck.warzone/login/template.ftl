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
          <input class="px-4 py-2.5 bg-white text-gray-800 rounded-lg outline-none border-brand-300 border-dashed ring-1 ring-offset-2 ring-brand-500 w-full focus:outline-none focus:border-brand-300 focus:border-dashed focus:ring-1 focus:ring-offset-2 focus:ring-brand-500" id="kc-attempted-username" value="${auth.attemptedUsername}" readonly>
      </div>
      <div class="ml-4">
        <button id="reset-login" class="py-2.5 px-4 rounded-lg border-2 border-brand-400 text-center text-brand-600 w-max" type="button" 
              aria-label="${msg('restartLoginTooltip')}" onclick="location.href='${url.loginRestartFlowUrl}'">
            <i class="fa-sync-alt fas" aria-hidden="true"></i>
            <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
        </button>
      </div>
    </@field.group>
</#macro>

<#macro registrationLayout pageId bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html class="scroll-smooth" <#if realm.internationalizationEnabled> lang="${locale.currentLanguageTag}" <#else>lang="en"</#if>>

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
    <link rel="icon" href="${url.resourcesPath}/img/logo.png" />
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
    <style>
      body {
        background-color: #f9fafb !important;
      }
      .text-brand-500 { color: #000000 !important; }
      .text-brand-600 { color: #00a6b4 !important; }
      .text-brand-700 { color: #005385 !important; }
      .text-brand-800 { color: #005385 !important; }
      .bg-brand-600 { background-color: #00a6b4 !important; }
      .border-brand-300 { border-color: #00a6b4 !important; }
      .border-brand-400 { border-color: #005385 !important; }
      .ring-brand-300 { --tw-ring-color: #00a6b4 !important; }
      .ring-brand-500 { --tw-ring-color: #005385 !important; }
      .ring-brand-600 { --tw-ring-color: #005385 !important; }
      .shadow-brand-600 { --tw-shadow-color: #005385 !important; }
      .hover\:bg-brand-500:hover { background-color: #005385 !important; }
      .hover\:text-brand-600:hover { color: #005385 !important; }
      .hover\:ring-brand-600:hover { --tw-ring-color: #005385 !important; }
      .focus\:border-brand-300:focus { border-color: #00a6b4 !important; }
      .focus\:ring-brand-300:focus { --tw-ring-color: #00a6b4 !important; }
      .focus\:ring-brand-500:focus { --tw-ring-color: #005385 !important; }
      .alert-error { border-color: #dc2626 !important; background-color: #fef2f2 !important; color: #991b1b !important; }
      .alert-error .text-red-500 { color: #dc2626 !important; }
      .alert-general { border-color: #dc2626 !important; background-color: #fef2f2 !important; color: #991b1b !important; }
      .alert-general .text-red-500 { color: #dc2626 !important; }
      .alert-general { --tw-shadow-color: rgb(220 38 38 / 0.2) !important; --tw-shadow: var(--tw-shadow-colored) !important; }
      .alert-error { --tw-shadow-color: rgb(220 38 38 / 0.2) !important; --tw-shadow: var(--tw-shadow-colored) !important; }
      
      /* Custom styles for login toggle */
      .login-toggle-btn {
        background-color: #ffffff;
        border: 1px solid #d1d5db;
        color: #374151;
        padding: 12px 16px;
        border-radius: 8px;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        font-size: 16px;
        font-weight: 500;
        transition: all 0.2s ease;
        cursor: pointer;
      }
      
      .login-toggle-btn:hover {
        background-color: #f9fafb;
        border-color: #9ca3af;
      }
      
      .traditional-login-form {
        display: none;
      }
      
      .traditional-login-form.show {
        display: block;
      }
      
      /* Show form automatically on registration page */
      body:has(#kc-register-form) .traditional-login-form {
        display: block;
      }
      
      /* RTL Support for Hebrew and Arabic */
      .rtl-text {
        direction: rtl;
        text-align: right;
      }
      
      .rtl-text-center {
        direction: rtl;
        text-align: center;
      }
      
      .rtl-text-left {
        direction: rtl;
        text-align: right;
      }
      

      
      /* Title font size and alignment */
      #kc-page-title-custom {
        font-size: 1.15rem !important;
        line-height: 2rem !important;
        font-weight: 600 !important;
        text-align: center !important;
      }
      
      /* Language selector should always be LTR */
      #login-select-toggle {
        direction: ltr !important;
        text-align: left !important;
      }
      
      #login-select-toggle option {
        direction: ltr !important;
        text-align: left !important;
      }
    </style>
</head>

<body id="keycloak-bg-custom" class="min-h-screen h-full">
  <div class="p-6 w-full mx-auto flex flex-col justify-center min-h-screen">
    <main class="max-w-sm w-full mx-auto">
      <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
        <div class="w-full flex justify-end mb-4">
          <select
            class="px-3 py-1.5 text-sm bg-white text-gray-800 rounded-md border border-gray-300 focus:outline-none focus:border-brand-300 focus:border-dashed focus:ring-1 focus:ring-offset-2 focus:ring-brand-500 pr-8"
            style="width: 120px !important; min-width: 100px !important;"
            aria-label="${msg("languages")}"
            id="login-select-toggle"
            onchange="if (this.value) window.location.href=this.value"
          >
            <#list locale.supported?sort_by("label") as l>
              <option
                value="${l.url}"
                ${(l.languageTag == locale.currentLanguageTag)?then('selected','')}
              >
                <#if l.languageTag == "he">עברית<#else>${l.label}</#if>
              </option>
            </#list>
          </select>
        </div>
      </#if>
      <header id="kc-header-custom" class="mb-12 text-3xl text-center" style="font-family: 'Assistant', sans-serif; font-weight: 700; transform: translateX(-50px);">
        <div class="flex items-center justify-center gap-4">
          <img src="${url.resourcesPath}/img/logo.png" alt="Logo" class="w-11 h-11 object-scale-down">
          <p class="text-2xl" style="font-family: 'Assistant', sans-serif; font-weight: 700; color: #005385;">BNEI BARUCH</p>
        </div>
      </header>
            <div class="border border-gray-200 rounded-lg p-6 bg-white shadow-lg">
                                            <div class="text-slate-700" style="margin-bottom: 20px;">
                    <h2 class="text-brand-500" id="kc-page-title-custom"><#nested "header"></h1>
                  </div>

                  <!-- Social Login First -->
                  <#if pageId == "login">
                    <div style="margin-bottom: 10px;">
                      <#nested "socialProviders">
                    </div>
                    <div id="or-divider" class="text-center">
                      <span class="text-gray-500 text-sm">${msg("or")}</span>
                    </div>
                    <div style="margin-top: 10px; margin-bottom: 0px;">
                      <button id="show-traditional-login" class="login-toggle-btn" onclick="toggleTraditionalLogin()" 
                              data-show-text="${msg("loginToggleShowForm")}" 
                              data-hide-text="${msg("loginToggleHideForm")}">
                        ${msg("loginToggleShowForm")}
                      </button>
                    </div>
                  </#if>
        
        <!-- Traditional Login Form -->
        <#if pageId == "login" || pageId == "register" || pageId == "reset-password" || pageId == "update-password">
          <div id="main-body" class="traditional-login-form <#if pageId == "reset-password" || pageId == "update-password">show</#if>">
            <#if pageId == "reset-password" || pageId == "update-password">
              <!-- For reset-password and update-password pages, always show the form content -->
              <div class="my-5"><#nested "form"></div>
            <#elseif !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
              <#if displayRequiredFields>
                <div class="text-brand-800 mt-3">
                  <span class="border border-brand-400 px-3 font-medium py-1 rounded-md text-sm bg-brand-50/75">
                    <span class="text-red-600">*</span> ${msg("requiredFields")}
                  </span>
                </div>
              </#if>
            <#else>
              <#if displayRequiredFields>
                <div class="text-brand-800 mt-3">
                  <span class="border border-brand-400 px-3 font-medium py-1 rounded-md text-sm bg-brand-50">
                    <span class="text-red-600">*</span> ${msg("requiredFields")}
                  </span>
                </div>
                <div>
                  <#nested "show-username">
                  <@username />
                </div>
              <#else>
                <div>
                  <#nested "show-username">
                  <@username />
                </div>
              </#if>
            </#if>

            <#-- Show alerts if needed -->
            <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
              <@loginAlert.alert message=message />
            </#if>

            <#-- Render the main form if not logout success and not reset-password or update-password pages -->
            <#if pageId != "reset-password" && pageId != "update-password" && !(message?? && message.summary?? && message.summary == msg("successLogout"))>
              <div class="my-5"><#nested "form"></div>
            </#if>

            <#-- Try another way link -->
            <#if auth?has_content && auth.showTryAnotherWayLink()>
              <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post" novalidate="novalidate">
                <input type="hidden" name="tryAnotherWay" value="on"/>
                <a id="try-another-way" class="text-brand-600 transition ring-1 ring-brand-300 hover:ring-brand-600 py-1 px-2 rounded-md text-sm" href="javascript:document.forms['kc-select-try-another-way-form'].submit()">
                  ${kcSanitize(msg("doTryAnotherWay"))?no_esc}
                </a>
              </form>
            </#if>
          </div>
        </#if>
      
      <!-- Registration Link - Always Visible -->
      <#if pageId == "login" && displayInfo>
        <div id="kc-info" class="mt-6">
            <div id="kc-info-wrapper" class="text-gray-600 text-center">
                <#nested "info">
            </div>
        </div>
      </#if>
    </main>
    <@loginFooter.content/>
  </div>
  
  <script>
    function toggleTraditionalLogin() {
      const form = document.getElementById('main-body');
      const button = document.getElementById('show-traditional-login');
      const socialProviders = document.getElementById('kc-social-providers');
      const orDivider = document.getElementById('or-divider');
      
      if (form.classList.contains('show')) {
        // Hide traditional form and show social providers
        form.classList.remove('show');
        if (socialProviders) {
          socialProviders.style.display = 'block';
        }
        if (orDivider) {
          orDivider.style.display = 'block';
        }
        button.innerHTML = button.dataset.showText;
      } else {
        // Show traditional form and hide social providers
        form.classList.add('show');
        if (socialProviders) {
          socialProviders.style.display = 'none';
        }
        if (orDivider) {
          orDivider.style.display = 'none';
        }
        button.innerHTML = button.dataset.hideText;
      }
    }
  </script>
</body>
</html>
</#macro>
