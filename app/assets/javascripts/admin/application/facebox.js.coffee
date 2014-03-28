$ ->
  $.facebox.settings.loadingImage = '/assets/facebox/loading.gif'
  $.facebox.settings.closeImage = '/assets/facebox/closelabel.gif'
  $.facebox.settings.opacity = 0.1
  $.facebox.settings.faceboxHtml__ = """
    <div id="facebox" style="display:none;">
      <div class="popup">
        <table>
          <tbody>
            <tr>
              <td class="tl"/><td class="b"/><td class="tr"/>
            </tr>
            <tr>
              <td class="b"/>
              <td class="body">
                <div class="content">
                </div>
                <div class="footer">
                  <a href="#" class="close"></a>
                </div>
              </td>
              <td class="b"/>
            </tr>
            <tr>
              <td class="bl"/><td class="b"/><td class="br"/>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  """
  
  # $(document).on 'reveal.facebox', -> $('#facebox a[rel=facebox]').facebox()
  $(document).on 'page:change', -> $('a[rel=facebox]').facebox()
  # $(document).on 'mousedown', 'a[rel=facebox]', -> $(this).facebox()
