-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- 기본적인 LazyVim 옵션은 이미 로드되어 있음. 아래는 덮어쓰기용.
local opt = vim.opt
vim.g.lazyvim_check_order = false
-- 줄 번호: 현재 줄은 숫자, 나머지는 상대 번호 (점프할 때 편함)
opt.relativenumber = true

-- 탭 설정 (기본 2칸, 필요시 4칸으로 변경)
-- Go는 자동으로 탭을 사용하므로 건들지 않아도 됨 (ftplugin이 알아서 함)
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true -- 스페이스바 사용

-- UI 관련
opt.scrolloff = 8 -- 커서가 화면 끝에 닿기 전에 스크롤 (8줄 여유)
opt.sidescrolloff = 8
opt.wrap = false -- 긴 줄 줄바꿈 끄기 (코드는 가로로 보는 게 나음)

-- 검색
opt.ignorecase = true -- 대소문자 무시
opt.smartcase = true -- 대문자가 섞이면 대소문자 구별

-- 시스템 클립보드 사용 (복사/붙여넣기 연동)
opt.clipboard = "unnamedplus"

-- 인코딩 (한글 깨짐 방지)
opt.fileencoding = "utf-8"

-- 분할 창 방향 (오른쪽, 아래쪽이 더 직관적)
opt.splitright = true
opt.splitbelow = true
