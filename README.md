

# ����͉�

���{�ꕶ���R�[�h�̈Öٕϊ����m�F���邽�߂̃f�[�^�����p�X�N���v�g�ނł��B


# ���{�ꕶ���R�[�h�̈Öٕϊ�

��Ƃ��� Windows ���o���܂����A
Windows �ł� ANSI�R�[�h�y�[�W cp932 (���� Shift_JIS)��
NEC���ꕶ���AIBM�g�������ANEC�I��IBM�g���������T�|�[�g����Ă��܂��B

�����̕������N���b�v�{�[�h�o�R�ŃR�s�[���y�[�X�g������Ƃ��A
������Unicode�ւ̕ϊ����s����ƁA�قȂ镶���R�[�h�֕ϊ�����܂��B
cp932 �œ��ꕶ���ɑ΂��ĕ����̕����R�[�h�����蓖�Ă��Ă��邽�߂ł��B

�Ⴆ�΃n�V�S���͈ȉ��̒ʂ�B

NEC�I��IBM�g�������Feee0
IBM�g�������Ffbfc

�������UUnicode���o�R����Ƃǂ���� fbfc �ɕϊ�����܂��B

�o�C�i����v���s�v�Ȃ�Windows�Ŏg�p��̖��͂���܂���B

�����A�[���\�t�g��ϊ��\�t�g���̋������m�F����Ƃ��ɕϊ��ς݂̕�����\�������Ă����퓮�삩�킩��܂���B
�ł��̂ŁA�����������ϊ��O�̏�Ԃ��m�F���邽�߂ɁASJIS�̐�������𐶐����邽�߂̃X�N���v�g���ɂȂ�܂��B

�����ł� Windows �̋������Љ�܂������A���ꕶ���ɕ����̃R�[�h�|�C���g�����邽�߁A
����ȊO�̃\�t�g�E�F�A�ł������R�[�h�ϊ��@�\��ʂ��Ɠ��l�̋������������܂��B


# �g�p���@
## gen_kanji_table.pl

�����\���o�͂��� Perl �X�N���v�g�ł��B

### �����ɐݒ�ł���ꗗ��\������
perl gen_kanji_table.pl -l

### NEC���ꕶ���̕\��\������
perl gen_kanji_table.pl -R nec

### IBM�g�������̕\��\������
perl gen_kanji_table.pl -R ibm

### NEC�I��IBM�g�������̕\��\������
perl gen_kanji_table.pl -R necibm

### ���s�R�[�h��CRLF�ł͂Ȃ�LF�ɂ���
perl gen_kanji_table.pl -N raw -R necibm


## nonascii_hex.pl

ASCII �ȊO�̕�����16�i���ŕ\������ Perl �X�N���v�g�ł��B
```bash
$ diff sjis_nec.txt Pasted-to-Notepad-sjis_nec.txt
9c9
< 8790:  �� �� �� �� �� �� �� ��  �� �� �� �� �� <
---
> 8790:  �� �� �� �� �� �� �� ��  �� �� �� �� �� <
$
$ diff sjis_nec.txt Pasted-to-Notepad-sjis_nec.txt | perl nonascii_hex.pl
9c9
< 8790: 8790 8791 8792 8793 8794 8795 8796 8797 8798 8799 879a 879b 879c <
---
> 8790: 81e0 81df 81e7 8793 8794 81e3 81db 81da 8798 8799 81e6 81bf 81be <
$
```

# �T���v���t�@�C��
## sample_text �f�B���N�g��
|filename|�T�v|
| ---- | ---- |
|Pasted-to-Notepad-sjis_ibm.txt|sjis_ibm.txt ���������ŊJ���ĕʂ̃������ɃR�s�[���y�[�X�g����ANSI�R�[�h�y�[�W�ŕۑ������t�@�C��|
|Pasted-to-Notepad-sjis_nec.txt|sjis_nec.txt ���������ŊJ���ĕʂ̃������ɃR�s�[���y�[�X�g����ANSI�R�[�h�y�[�W�ŕۑ������t�@�C��|
|Pasted-to-Notepad-sjis_necibm.txt|sjis_necibm.txt ���������ŊJ���ĕʂ̃������ɃR�s�[���y�[�X�g����ANSI�R�[�h�y�[�W�ŕۑ������t�@�C��|
|sjis_ibm.txt|gen_kanji_table.pl �Ő������� IBM�g������ �̕\|
|sjis_nec.txt|gen_kanji_table.pl �Ő������� NEC���ꕶ�� �̕\|
|sjis_necibm.txt|gen_kanji_table.pl �Ő������� NEC�I��IBM�g������ �̕\|

# ���C�Z���X LICENSE
Perl �X�N���v�g�̂� MIT ���C�Z���X�ł��B
sample_text �f�B���N�g���̃t�@�C���͎v�z�����߂��Ă��Ȃ����앨�Ƃ͌����Ȃ��f�[�^�ł��BCC0 �Ƃ��܂��B

- SPDX-License-Identifier: MIT
  - README.md
  - gen_kanji_table.pl
  - nonascii_hex.pl

- CC0
  - sample_text/*.txt

