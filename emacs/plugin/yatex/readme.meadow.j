 Meadow(Mule for Windows) �ւ� �쒹�̃C���X�g�[��
*************************************************************

�쒹�̃C���X�g�[���́A�ȉ���3�X�e�b�v�Ŋ������܂��B

(1) �����ݒ�t�@�C��(~/.emacs)�̐ݒ�
(2) Emacs Lisp�t�@�C��(*.el)�̃R�s�[
(3) �戵������(help/info)�̐ݒ�

���ɐ������܂��B


(1) �����ݒ�t�@�C��(~/.emacs)�̐ݒ�

Emacs�́A���[�U���ꂼ��̏����ݒ���z�[���f�B���N�g��(~/)�̒��ɂ���
.emacs�Ƃ����t�@�C��(���邢��.emacs.el�Ƃ����t�@�C��)����ǂݍ��݂܂��B

�����ł́A�g���q��.tex�ł���t�@�C����ǂݍ��ނƁA�����I�ɖ쒹���ǂݍ�
�܂��悤�ɐݒ肵�܂��B

�܂� ~/.emacs�ɉ���2���ڂ������܂��B

	(setq auto-mode-alist
	      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
	(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

���ɖ쒹�� emacs-lisp �t�@�C���Q��u���f�B���N�g���� load-path �ɉ����܂��B
���Ƃ��΁A`~/src/emacs/yatex'�ɒu���̂ł���΁A

	(setq load-path (cons "~/src/emacs/yatex" load-path))

�ȂǂƂ��܂��B�����ApLaTeX2e, dviout �Ȃǂ̃R�}���h���C���X�g�[��������
����PATH��ʂ��Ă��Ȃ��Ƃ��͂����𖾎��I�Ɏw�肵�܂��B�ȉ��̗��
c:\ptex\bin ��LaTeX�֌W�̃R�}���h���C���X�g�[�����Ă���ꍇ�̎w��ł��B

	(setq tex-command "c:/ptex/bin/platex")
	(setq dvi2-command "c:/ptex/bin/dviout")

����ŁA�����ݒ�t�@�C���̐ݒ�͏I���ł��B



(2) Emacs Lisp�t�@�C��(*.el)�̃R�s�[

Emacs Lisp�ŏ����ꂽ�쒹�{�̂��C���X�g�[������ɂ́A(i) make���g�����@
�ƁA(ii) �蓮�ŃR�s�[������@�Ƃ�����܂��B


(i) make���g�����@

Windows���� Unix ���C�N�ȃR�}���h��񋟂���uCygwin�v�𓱓������肵
�āAmake���g������ɂ�����́A���̂悤�ȕ��@�ŃC���X�g�[���ł��܂��B
�����łȂ�����(ii)�ɐi��ł��������B

�܂��AEmacs�Ȃǂ̃G�f�B�^�ł��̃t�@�C���Ɠ����f�B���N�g���ɂ���
makefile�Ƃ����t�@�C�����J���A�����̊��ɂ��킹�ĕҏW���܂��B

���Ƃ��΁A

PREFIX	= /usr/local���APREFIX = /usr�ɂ�����A

## mule2
EMACS	= mule
EMACSDIR= ${PREFIX}/lib/${EMACS}
## emacs20
#EMACS	= emacs
#EMACSDIR= ${PREFIX}/share/${EMACS}
## XEmacs
#EMACS	= xemacs
#EMACSDIR= ${PREFIX}/lib/${EMACS}

�������̎g���Ă���Emacs�̎�ނɂ��킹���肵�܂��B�s����#������ƃR��
���g�����ƂȂ�A���̍s�͖���������܂��B���̍s��L���ɂ��邽�߂ɂ́A�s
����#���O���܂��B

�܂��A���̍s�̍s����#�����Ă��������B

GEO	= -geometry 80x20+0+0


�ȉ��͏��������������̗�ł�

PREFIX=/usr/local/meadow
EMACS=meadow
EMACSDIR=${PREFIX}/site-lisp
#GEO	= -geometry 80x20+0+0

�ȏ�̍�Ƃ��I�������Amakefile��ۑ����Abash�Ȃǂ̃V�F���ŁA

	% export DISPLAY=":0.0"
	% make install 

�Ƃ���΁A�C���X�g�[������܂��B

(3)�̎戵�������̃C���X�g�[������{�I�ɂ͏I����Ă��܂����AEmacs�����
�߂�悤�ɂ��邽�߂ɁAinfo �f�B���N�g���� dir �Ƃ����t�@�C���ɂ��̃f�B
���N�g���� dir �t�@�C���̒��g��ǉ����Ă��������B



(ii) �蓮�ŃR�s�[������@

Windows���Ȃǂ�make���Ȃ�������A��L(i)��make install�����s����ꍇ
�́A�蓮�ŕK�v�t�@�C�����C���X�g�[��(�R�s�[)���邱�Ƃ��ł��܂��B

���Ƃ��΁AMeadow �p�̊O��Emacs-Lisp�p�b�P�[�W���C���X�g�[������f�B���N
�g���� /usr/local/meadow/site-lisp/ �������Ƃ��܂��B���̏ꍇ�A
���̃A�[�J�C�u(yatex<VERSION>.tar.gz)��W�J�����f�B���N�g��
(yatex<VERSION>) �������Ɉړ����܂��B����ƁA
/usr/local/meadow/site-lisp/yatex<VERSION>/ �Ƃ����f�B���N�g
���ɂȂ�܂��̂ŁA������o�[�W�����ԍ�������
/usr/local/meadow/site-lisp/yatex/
�ɂ��܂��B

����Ŗ쒹�͎g����悤�ɂȂ��Ă���͂��ł����A����Ɏ��s���x���킸���΂�
��҂����߁AEmacs Lisp�t�@�C�����R���p�C��(�o�C�g�R���p�C��)���邱�Ƃ���
���܂��B�������A�o�C�g�R���p�C������菇�����܂��Ă���̂Ŏ蓮�ł��̂�
Emacs�ɂ��Ă̒m�����K�v�ł��B����Ƀo�C�g�R���p�C�����Ă������ł����
�Ǒ����͂Ȃ�Ȃ��̂ł��܂肨���߂��܂���B����ł��o�C�g�R���p�C��������
�ꍇ�́ACygwin�ȂǁAmake�̎g�������p�ӂ��āA����Ŏ����I�ɏ��������
���ǂ��Ǝv���܂��B

(3) �戵������(help/info)�̐ݒ�

���ɁA�e��̐��������C���X�g�[�����܂��B

LaTeX�}�N���̗��p������ł��� help/YATEXHLP.jp �t�@�C����
/usr/local/meadow/site-lisp/
�ɃR�s�[���܂��B

�쒹���g�̃}�j���A���ł��� docs/yatexj, docs/yatexe ��
yahtml �̃}�j���A���ł��� docs/yahtmlj, docs/yahtmle ��
/usr/local/meadow/1.10/info/
�ɃR�s�[���Ainfo �f�B���N�g���� dir �Ƃ����t�@�C����
���̃f�B���N�g���� dir �t�@�C���̒��g��ǉ����܂��B

�ȏ�ŃC���X�g�[���͊����ł��B
