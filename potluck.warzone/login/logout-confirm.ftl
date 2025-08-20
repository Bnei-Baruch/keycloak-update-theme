<#import "template.ftl" as layout>

<style>
  /* RTL styling specifically for logout-confirm page */
  .logout-confirm-container[lang="he"] .logout-header-text,
  .logout-confirm-container[lang="ar"] .logout-header-text,
  .logout-confirm-container[lang="fa"] .logout-header-text {
    direction: rtl;
    text-align: center;
  }
  
  .logout-confirm-container[lang="he"] .logout-question-text,
  .logout-confirm-container[lang="ar"] .logout-question-text,
  .logout-confirm-container[lang="fa"] .logout-question-text {
    direction: rtl;
    text-align: center;
  }
  
  .logout-confirm-container[lang="he"] .kc-actions,
  .logout-confirm-container[lang="ar"] .kc-actions,
  .logout-confirm-container[lang="fa"] .kc-actions {
    direction: rtl;
    text-align: center;
    justify-content: center;
  }
</style>

<@layout.registrationLayout pageId="logout-confirm" displayMessage=!messagesPerField.existsError('logout'); section>
  <#if section == "header">
    <span class="logout-header-text">${msg("logoutConfirmTitle")!"Logging out"}</span>
  <#elseif section == "form">
    <div class="logout-confirm-container" lang="${locale.currentLanguageTag}">
      <form id="kc-logout-form" action="${url.logoutConfirmAction}" method="post" novalidate="novalidate">
        <!-- Required hidden fields -->
        <input type="hidden" name="session_code" value="${logoutConfirm.code}"/>

        <p class="mb-4 logout-question-text">${msg("logoutConfirmHeader")!"Do you want to log out?"}</p>

        <div class="kc-actions">
          <!-- Confirm button: real POST submit -->
          <button type="submit" id="logout" name="confirmLogout" value="yes" class="bg-brand-600 hover:bg-brand-500 text-white font-medium py-2 px-4 rounded-lg transition-colors duration-200">
            ${msg("doLogout")}
          </button>

          <!-- Cancel button: sends name=cancel to return to the application -->
          <button type="submit" id="back-to-app" name="cancel" class="bg-gray-300 hover:bg-gray-400 text-gray-700 font-medium py-2 px-4 rounded-lg transition-colors duration-200 ml-3">
            ${msg("backToApplication")}
          </button>
        </div>
      </form>
    </div>
  </#if>
</@layout.registrationLayout>


