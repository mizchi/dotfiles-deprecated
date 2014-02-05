/* NEW BSD LICENSE {{{
Copyright (c) 2012, anekos.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice,
       this list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright notice,
       this list of conditions and the following disclaimer in the documentation
       and/or other materials provided with the distribution.
    3. The names of the authors may not be used to endorse or promote products
       derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
THE POSSIBILITY OF SUCH DAMAGE.


###################################################################################
# http://sourceforge.jp/projects/opensource/wiki/licenses%2Fnew_BSD_license       #
# に参考になる日本語訳がありますが、有効なのは上記英文となります。                #
###################################################################################

}}} */

// INFO {{{
let INFO = xml`
  <plugin name="Newtab" version="1.0.0"
          href="http://vimpr.github.com/"
          summary="Add about:newtab URL Completer."
          lang="en-US"
          xmlns="http://vimperator.org/namespaces/liberator">
    <author email="anekos@snca.net">anekos</author>
    <license>New BSD License</license>
    <project name="Vimperator" minVersion="3.0"/>
    <p>
      Add completer.
      <code><![CDATA[
        :set complete+=n
      ]]></code>
    </p>
  </plugin>
`;
// }}}

(function () {

  // ~/repos/mozilla-central/browser/modules/NewTabUtils.jsm

  let NTU = {};
  Cu.import("resource:///modules/NewTabUtils.jsm", NTU);

  delete completion.urlCompleters.n;

  completion.addUrlCompleter(
    'n',
    'about:newtab completer',
    function (context, args) {
      context.title = ['about:newtab', 'Title'];
      context.filters = [CompletionContext.Filter.textAndDescription];
      context.completions = [
        [t.url, t.title]
        for ([, t] in Iterator(NTU.NewTabUtils.links.getLinks()))
      ];
    }
  );

})();

// vim:sw=2 ts=2 et si fdm=marker:
