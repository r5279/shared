#!/usr/bin/env bash

# ---------------------------------------------------------------------------
# tmux 설정 심볼릭 링크 생성 스크립트
# ---------------------------------------------------------------------------
#
# 목적
# ----
# tmux는 기본적으로 사용자 설정 파일을 다음 경로에서 자동으로 읽는다.
#
# ~/.tmux.conf
#
# 그러나 설정 파일을 Git 등으로 관리하기 위해 실제 파일을 다른 위치
# (예: ~/shared/tmux.conf)에 두고, ~/.tmux.conf 는 **symbolic link**로
# 연결하는 방식이 자주 사용된다.
#
# 이 스크립트는 다음 작업을 수행한다.
#
# 1. 실제 설정 파일 위치
#
# ~/shared/tmux.conf
#
# 2. tmux가 읽는 기본 경로
#
# ~/.tmux.conf
#
# 3. ~/.tmux.conf 를 symbolic link로 생성하여 위 파일을 가리키도록 설정
#
# 결과 구조:
#
# ~/.tmux.conf  ->  ~/shared/tmux.conf
#
# 장점
# ----
# - tmux는 기존 방식 그대로 ~/.tmux.conf 를 읽음
# - 실제 설정 파일은 ~/shared 아래에서 Git 관리 가능
# - 여러 컴퓨터에서 동일한 설정을 쉽게 재사용 가능
#
# 사용 방법
# ----------
#
# 1. 이 스크립트를 예: setup_tmux_link.sh 로 저장
#
# 2. 실행 권한 부여
#
# chmod +x setup_tmux_link.sh
#
# 참고
# ----
# ln 옵션 설명
#
# -s : symbolic link 생성
# -f : 기존 파일이 있으면 강제로 교체
#
# ---------------------------------------------------------------------------

TARGET="$HOME/shared/tmux.conf"
LINK="$HOME/.tmux.conf"

echo "Creating tmux config symlink..."
echo "Link:   $LINK"
echo "Target: $TARGET"

ln -sf "$TARGET" "$LINK"

echo "Done."
echo "Result:"
ls -l "$LINK"
