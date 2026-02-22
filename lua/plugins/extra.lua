return {
  -- 1. Harpoon (ThePrimeagen 추천): 자주 가는 파일 4~5개를 지정해서 빠르게 이동
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      {
        "<leader>a",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon 파일 추가",
      },
      {
        "<C-e>",
        function()
          require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
        end,
        desc = "Harpoon 메뉴",
      },
    },
  },

  -- 2. Refactoring.nvim: 함수 추출, 변수 추출 등 리팩토링 기능 (Go/TS에 유용)
  {
    "ThePrimeagen/refactoring.nvim",
    keys = {
      {
        "<leader>r",
        function()
          require("refactoring").select_refactor_menu()
        end,
        mode = "v",
        desc = "리팩토링 메뉴 (변수/함수 추출)",
      },
    },
    config = true,
  },

  -- 3. Rainbow Delimiters: 괄호 쌍을 색깔별로 보여줌 (함수 깊이가 깊어질 때 필수)
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
  },
}
