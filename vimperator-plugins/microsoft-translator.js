/* NEW BSD LICENSE {{{
Copyright (c) 2009-2010, anekos.
Copyright (c) 2012-2013, Jagua.
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
<plugin name="Microsoft Translator" version="1.0.1"
        href="http://github.com/vimpr/vimperator-plugins/blob/master/microsoft-translator.js"
        summary="Translate with Microsoft AJAX Language API"
        xmlns="http://vimperator.org/namespaces/liberator">
  <author email="anekos@snca.net">anekos</author>
  <author homepage="https://github.com/Jagua">Jagua</author>
  <license>New BSD License</license>
  <project name="Vimperator" minVersion="2.3"/>
  <p>
    Translate with Microsoft AJAX Language API.
  </p>
  <item>
    <tags>:mstrans</tags>
    <spec>:mstrans <oa>-a<oa>ction</oa>=<a>actionName</a></oa> text</spec>
    <description>
      <p>
        Translate!!!!!!!!!!!
      </p>
      <p>
        You need to get an Access Token from http://www.bing.com/developers/appids.aspx
        to use this plugin. and add liberator.globalVariables.mstrans_appid setting
        to your ".vimperatorrc".
      </p>
      <p>The following options are interpreted.</p>
      <dl>
        <dt>-a<oa>ction</oa></dt>
        <dd>
          以下の<oa>actionName</oa>が設定可能
          <ul>
            <li>echo</li>
            <li>replace(not implemented)</li>
            <li>copy</li>
          </ul>
        </dd>
      </dl>
    </description>
  </item>
</plugin>`;
// }}}

(function () {

  const refererURL = 'https://github.com/vimpr/vimperator-plugins/raw/master/microsoft-translator.js';

  const languages = [
    ['ar', 'Arabic'],
    ['bg', 'Bulgarian'],
    ['ca', 'Catalan'],
    ['zh-CHS', 'Chinese (Simplified)'],
    ['zh-CHT', 'Chinese (Traditional)'],
    ['cs', 'Czech'],
    ['da', 'Danish'],
    ['nl', 'Dutch'],
    ['en', 'English'],
    ['et', 'Estonian'],
    ['fi', 'Finnish'],
    ['fr', 'French'],
    ['de', 'German'],
    ['el', 'Greek'],
    ['ht', 'Haitian Creole'],
    ['he', 'Hebrew'],
    ['hi', 'Hindi'],
    ['mww', 'Hmong Daw'],
    ['hu', 'Hungarian'],
    ['id', 'Indonesian'],
    ['it', 'Italian'],
    ['ja', 'Japanese'],
    ['ko', 'Korean'],
    ['lv', 'Latvian'],
    ['lt', 'Lithuanian'],
    ['ms', 'Malay'],
    ['no', 'Norwegian'],
    ['fa', 'Persian (Farsi)'],
    ['pl', 'Polish'],
    ['pt', 'Portuguese'],
    ['ro', 'Romanian'],
    ['ru', 'Russian'],
    ['sk', 'Slovak'],
    ['sl', 'Slovenian'],
    ['es', 'Spanish'],
    ['sv', 'Swedish'],
    ['th', 'Thai'],
    ['tr', 'Turkish'],
    ['uk', 'Ukrainian'],
    ['ur', 'Urdu'],
    ['vi', 'Vietnamese'],
    ['', 'Unknown']
  ];

  const settings = {
    get pair ()
      (liberator.globalVariables.microsoft_translator_pair || 'ja en').split(' '),
    get actions ()
      (liberator.globalVariables.microsoft_translator_actions || 'echo').split(' ')
  };

  function guessRequest (appId, text, done) {
    let url =
      'http://api.microsofttranslator.com/V2/Ajax.svc/Detect' +
      '?appId=' + appId +
      '&text=' + encodeURIComponent(text);
    let req =
      new plugins.libly.Request(
        url,
        {
            Referrer: refererURL,
        }
      );
    req.addEventListener(
      'onSuccess',
      function (res) {
        var result = res.responseText;
        done(result.substring(1,result.length-1));
      }
    );
    req.get();
  }

  function translateRequest (appId, text, opts /* from, to, done */) {
    opts || (opts = {});
    let url =
      'http://api.microsofttranslator.com/V2/Ajax.svc/Translate' +
      '?appId=' + appId +
      '&text=' + encodeURIComponent(text) +
      '&from=' + (opts.from || 'en') + '&to=' + (opts.to || 'ja') +
      '&contentType=text/plain'  ;
    let req =
      new plugins.libly.Request(
        url,
        {
            Referrer: refererURL,
        }
      );
    req.addEventListener(
      'onSuccess',
      function (res) {
        let translated = res.responseText;
        liberator.log('translated: ' + translated);
        opts.done(translated);
      }
    );
    req.get();
  }

  // 何語か妄想する
  // XXX 使ってないよ！
  function guess (text) {
    const codePatterns = {
      ja:
        /[\u3041-\u3093\u30A1-\u30F6\u30FC\u3005\u3007\u303B\u3400-\u9FFF\uF900-\uFAFF\u20000-\u2FFFF]/g,
      en:
        /[a-zA-Z]/g,
//      ko:
//        /[\uac00-\ud79f]/g,
    };

    function matchCount (s, re) {
      let r = 0;
      s.replace(re, function (m) (r += m.toString().length));
      return r;
    }

    let max = {lang: null, length: 0};
    for (let lang in codePatterns) {
      let len = matchCount(test, codePatterns[lang]);
      if (len > max.length)
        max = {lang: lang, length: len};
    }

    return max.lang || 'en';
  }


  let actions = {
    echo:
//      function (text) liberator.echo(text,commandline.FORCE_MULTILINE),
//      function (text) liberator.echo("<p style='width:200px'>"+text+"</p>",commandline.FORCE_MULTILINE),
//      function (text) liberator.echo("<p style='width:"+content.document.documentElement.clientWidth+"px'>"+text+"</p>",commandline.FORCE_MULTILINE),
//      function (text) liberator.echo("<div style='white-space:normal;word-break:normal;width:"+content.document.documentElement.clientWidth+"px;height:4em;overflow:auto;'>"+content.document.documentElement.clientWidth+text+"</div>",commandline.FORCE_MULTILINE),
//      function (text) liberator.echo("<div style='white-space:normal;word-break:normal;'>"+text+"</div>",commandline.FORCE_MULTILINE),
      function (text) liberator.echo("<div style='white-space:normal;'>"+text+"</div>",commandline.FORCE_MULTILINE),
    insert:
      // FIXME 見えない要素相手だとうまくいかない
      function (text) {
        let div = content.document.createElement('div');
        div.setAttribute('style', 'border: dotted 2px blue; padding: 5px;');
        div.textContent = text;
        let selection = content.window.getSelection();
        if (selection.rangeCount > 0) {
          let range = selection.getRangeAt(0);
          range.insertNode(div);
        }
      },
    copy:
      function (text) util.copyToClipboard(text, true)
  };

  function makeListValidator (list)
    function (vs) (!vs || !vs.some(function (v) !list.some(function (at) (v == at))));

  commands.addUserCommand(
    ['mstrans'],
    'Microsoft Translator',
    function (args) {
      let appId = liberator.globalVariables.mstrans_appid;
      let text = args.literalArg;
      let actionNames = args['-action'] || settings.actions;
      let [from, to] = [args['-from'], args['-to']];

      if (appId == undefined) {
        liberator.echoerr('The setting of liberator.globalVariables.mstrans_appid in .vimperatorrc is required.');
        return false;
      }

      if (!text)
        text = buffer.getCurrentWord();

      if (args['-guess']) {
        guessRequest(
          appId,
          text,
          function (lang) [liberator.echo("<p>"+v+"</p>",liberator.commandline.FORCE_MULTILINE) for ([, [k, v]] in Iterator(languages)) if (k == lang)]
        );
        return;
      }

      if (args.bang)
        actionNames.push('insert');

      if (!actionNames.length)
        actionNames.push('echo');

      function setPair () {
        if ((!from ^ !to) && settings.pair.length >= 2)
          let (v = settings.pair[(settings.pair[0] == (from || to)) - 0])
            (from ? (to = v) : (from = v));
      }

      function req () {
        translateRequest(
          appId,
          text,
          {
            done: function (text) actionNames.forEach(function (name) actions[name](text)),
            from: from,
            to: to
          }
        );
      }

      if (from) {
        setPair();
        req();
      } else {
        guessRequest(
          appId,
          text,
          function (fromLang) {
            from = fromLang;
            liberator.log('lang: ' + fromLang);
            setPair();
            if (args['-to'])
              to = args['-to'];
            req();
          }
        );
      }
    },
    {
      literal: 0,
      bang: true,
      options:
        let (actionTypes = [n for (n in actions)])
          [
            [
              ['-action', '-a'],
              commands.OPTION_LIST,
              makeListValidator(actionTypes),
              actionTypes.map(function (v) [v, v]),
              true
            ],
            [['-from', '-f'], commands.OPTION_STRING, null, languages],
            [['-to', '-t'], commands.OPTION_STRING, null, languages],
            [['-guess', '-g'], commands.OPTION_NOARG]
          ],
    },
    true
  );

})();

// vim:sw=2 ts=2 et si fdm=marker:
