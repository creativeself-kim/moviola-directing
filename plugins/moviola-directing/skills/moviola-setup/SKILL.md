---
name: moviola-setup
description: Set up a MOVIOLA work folder — pick the Project on the server, write the project card, pull the plans and notes already on the server down into the folder, and point the instruction file this client reads (CLAUDE.md or AGENTS.md) at it. Also reports whether MOVIOLA MCP and the local Blender pieces are ready. Run once per work folder, by name, before directing from that folder — including on a new machine.
disable-model-invocation: true
---

# MOVIOLA 작품 폴더 세팅

감독의 컴퓨터에 작품 폴더 한 자리를 잡는다. 세션을 넘겨야 하는 것 — 씬별 계획, 표본
대응표, 클라이언트 원문, 시도했다 버린 안과 이유 — 이 그 자리에 남고, 다음 세션의
조연출이 그것을 읽고 이어서 일한다.

같은 내용이 무비올라에도 한 벌 산다. **새 컴퓨터에서는 세팅을 한 번 돌리면 통째로
내려온다** — 감독이 하는 일은 작품을 고르는 것 하나다.

세팅이 하는 일은 셋이다.

- **`## MOVIOLA` 블록** — 이 클라이언트가 읽는 지시 파일(`CLAUDE.md` 또는 `AGENTS.md`)에
  넣는다. 이 자리가 무슨 작품인지와 `moviola/` 를 가리킨다. 터미널이 이 폴더에서 켜지면
  자동으로 읽히므로, 조연출이 폴더를 뒤지거나 등록부를 볼 일이 없다.
- **`moviola/project.md`** — 서버 주소 · project_id · 지금 쓰는 draft_id. 이 파일은
  **서버에서 안 받는다.** 서버를 찾아가는 쪽지라 서버에 없다 — 목록에서 고른 값으로
  새로 쓴다. **감독이 손으로 쓰는 것이 아니다.**
- **서버에 올라와 있는 계획과 노트를 받아 온다** — `plans/` 와 `notes/`.

**경로는 정해져 있다. 감독에게 묻지 마라.** 작품 카드는 `moviola/project.md`, 씬별
계획은 `moviola/plans/draft-<draft_id 앞 8자>.md`, 클라이언트 원문과 버린 안은
`moviola/notes/`. **한글 제목은 파일을 여는 첫 줄에 쓴다.**

`plans/` 와 `notes/` 는 **빈 채로 미리 만들지 않는다.** 필요할 때 생긴다.

정해진 스크립트가 아니라 대화로 도는 스킬이다. 살피고, 찾은 것을 보여주고, 확인받고,
쓴다.

## 걸음

### 1. 살핀다

지금 자리를 읽는다. 짐작하지 말고 실제로 본다.

- `moviola/project.md` 가 이미 있나 — 있으면 **다시 잡는 자리**다. 읽어서 무엇이 이미
  정해졌는지 확인한다. 그 서버 줄을 지금 붙은 MCP 주소(아래 '서버 주소'에서 읽는다)와
  견준다 — **둘 다 끝의 `/mcp` 나 `/mcp/` 를 떼고 견준다.** 다르면 **멈추고** 두 주소를
  보여준다 — 다른 서버의 작품 폴더다. 클라이언트를 카드의 서버로 다시 붙일지, 이 폴더를
  다른 서버로 갈아탈지(4번 끝의 ②), 다른 폴더를 쓸지 감독이 정하기 전에는 작품을 다시
  고르지도, 이 폴더의 계획·노트를 다른 작품에 잇지도 않는다.
- `moviola/decisions/` 가 있나 — 계획이 살던 **옛 이름**이다. 지금 이름은
  `moviola/plans/` 다. 있으면 4번에서 옮긴다.
- `moviola/plans/` · `moviola/notes/` 에 파일이 있나 — 있으면 4번에서 그 자리는
  건너뛴다. 경로를 그대로 적어 둔다.
- `git rev-parse --is-inside-work-tree` — 여기가 git 저장소 안인가. 안이면
  `git rev-parse --show-toplevel` 로 저장소 뿌리가 어디인지도 본다.
- `CLAUDE.md` · `AGENTS.md` 가 있나. 있으면 그 안에 `## MOVIOLA` 블록이 이미 있나. 위
  폴더의 것도 본다 — 위 폴더의 지시 파일도 함께 읽힐 수 있다.
- 저장소 안이면 `git check-ignore -q moviola/` — `moviola/` 가 이미 무시되고 있나.
  파일을 눈으로 찾지 말고 이걸로 물어라. 무시 규칙은 위 폴더의 `.gitignore` 에 있을 수도
  있다. **끝의 빗금을 빼지 마라** — `moviola/` 규칙은 폴더에만 걸리고, 폴더가 아직 없으면
  빗금 없는 `moviola` 는 안 걸린 것으로 나온다.

**이 클라이언트가 실제로 읽는 지시 파일을 확인한다.** 파일 이름으로 짐작하지 마라. 이
폴더에서 켜진 세션이면 지금 맥락에 실려 온 지시 파일이 곧 그 파일이다. 맥락으로 알 수
없을 때만(다른 자리를 골랐거나 파일이 방금 생겼을 때) 아래 기본을 쓴다 — 버전과 설정에
따라 바뀌므로 실제로 실린 것이 이긴다.

- **Claude Code** — 이 폴더나 그 위 어디에든 `CLAUDE.md` · `.claude/CLAUDE.md` ·
  `CLAUDE.local.md` 가 하나라도 있으면 그것만 읽는다. 없을 때만 `AGENTS.md` 를 읽고, 옛
  버전이나 설정에 따라서는 그때도 안 읽는다.
- **Codex** — 폴더마다 `AGENTS.override.md`, 없으면 `AGENTS.md` 를 읽는다. `CLAUDE.md` 는
  설정의 `project_doc_fallback_filenames` 에 적혀 있을 때만 읽는다.

**블록이 둘 이상이면 가리키는 작품을 견준다.** 두 파일에, 또는 위 폴더의 파일에 블록이
있으면 블록마다 그 작품 카드를 읽는다 — 카드 경로는 블록이 든 파일의 폴더 기준이다. 같은
작품인지는 카드의 **서버 주소(위처럼 끝을 떼고)와 project_id** 로 가린다. 같으면 한
작품이다 — 경로가 달라도 각 블록이 제 폴더 기준으로 맞는 카드를 가리키면 그대로 둔다. 두
카드가 서로 다른 파일이고 draft_id 나 자리가 다르면 그 차이를 2번 요약에 한 줄로 적고,
어느 쪽에 맞출지는 감독이 정한다. 세팅이 고치는 것은 이 작품 폴더의 파일뿐이고 위 폴더의
파일은 고치지 않는다. 다르면 **멈추고** 둘을 나란히 보여준 뒤 이 폴더가 어느 작품인지
묻는다. 답을 받은 뒤에도 다른 쪽 블록은 감독이 정리한다.

그리고 **MOVIOLA MCP 도구로 서버를 읽는다.**

- `list_projects` — 감독이 고를 수 있는 작품 목록.
- 작품이 정해진 뒤 `list_drafts` — 그 작품의 드래프트 목록.
- 작품이 정해진 뒤 `list_work_files` — 그 작품의 폴더에 올라와 있는 파일 목록. 내용은
  안 온다. 여기 나온 것을 4번에서 한 장씩 받는다.

**살펴서 이미 정해진 항목은 2번에서 다시 묻지 않는다.** 이미 있는 `project.md` 의
작품, 이미 들어 있는 `.gitignore` 줄이 그렇다. 무엇을 건너뛰었는지는 요약에 한 줄로
적는다.

`list_projects` 가 광고되지 않았거나, 불렀는데 읽히지 않으면(토큰이 거절되면) 거기서
**멈추고 말한다** — 작품 값 없이 쓴 파일은 다음 세션에 아무 데도 못 닿는다. 무엇이
빠졌는지와 함께 공식 연결 안내를 댄다:
<https://moviola.vibeproduction.ai/docs#terminal--connect>

- 토큰은 MOVIOLA 웹의 설정 → 개인 토큰에서 발급해 셸의 `MOVIOLA_PAT` 에 둔다. 원문을
  대화에 붙여 달라고 하지 마라.
- Claude Code — `claude mcp add --transport http --scope user moviola <서버>/mcp --header 'Authorization: Bearer ${MOVIOLA_PAT}'`
  (작은따옴표 그대로 — Claude Code 가 켜질 때 값을 채운다)
- Codex — `codex mcp add moviola --url <서버>/mcp --bearer-token-env-var MOVIOLA_PAT`
- `moviola` 가 이미 등록돼 있으면 더하지 말고 그 항목을 고친다. 토큰이 거절됐으면 새로
  발급해 `MOVIOLA_PAT` 만 바꾼다.
- 그다음 **세션을 새로 연다** — 도구 목록은 붙을 때 한 번 정해진다. 그리고 세팅을 다시
  부른다.

명령은 감독이 돌린다. 세팅은 클라이언트 설정을 쓰지도 덮지도 않는다.

**서버 주소는 도구 결과에 없다.** 붙어 있는 MCP 설정에서 `url` 한 칸만 읽는다. 토큰 ·
헤더 · `env` 는 화면에 내지도 옮겨 적지도 마라.

- Claude Code — `claude mcp list` 의 `moviola` 줄. `claude mcp get` 은 헤더를 토큰째
  보여 주니 부르지 마라.
- Codex — `codex mcp get moviola --json | jq -r .transport.url`. 이 명령은 실제
  `$CODEX_HOME/config.toml` — `CODEX_HOME` 이 없으면 `~/.codex/config.toml` — 에 신뢰한
  프로젝트의 `.codex/config.toml` 을 얹은 값을 준다. 명령을 못 쓰면 파일을 열지 말고 각
  파일에서 `url` 줄만 걸러 읽는다 — 프로젝트 쪽이 이긴다.
  `sed -n '/^\[mcp_servers\.moviola\]/,/^\[/{/^url *=/p;}' <파일>`

못 찾으면 감독에게 물어라. **지어내지 마라.**

**Blender 쪽 준비는 보고만 한다.** 3D 씬을 이 컴퓨터의 Blender 로 만들 때만 필요하고,
없어도 세팅은 계속한다. 셋을 차례로 본다 — 앞이 없으면 뒤는 못 본다. 실행기로 돌리는
것은 아래 코드 하나뿐이다.

- **Blender 실행기** — 이 세션에 Blender 의 Python 실행 도구(`execute_blender_code`)가
  광고되나. 없으면 호환 실행기인 MCP for Blender 의 설치·갱신 안내를 댄다 —
  <https://github.com/ahujasid/mcp-for-blender> (커뮤니티 플러그인이다. Blender 재단 것이
  아니다). 붙인 뒤 Blender 에서 그 애드온을 켜고 세션을 새로 연다.
- **켜진 `moviola_vcam`** — 실행기로 아래를 돌린다. 디스크에 확장 폴더가 있어도 켜졌다는
  증거가 아니라서 켜진 확장 목록만 보고, 하나일 때만 Scene 명령의 읽기 전용 `status` 를
  부른다.

  ```python
  import bpy, importlib
  modules = [a.module for a in bpy.context.preferences.addons
             if a.module.rsplit(".", 1)[-1] == "moviola_vcam"]
  print(modules)
  if len(modules) == 1:
      print(importlib.import_module(modules[0] + ".scene_commands").execute("status"))
  ```

  다른 checkout 을 `sys.path` 에 넣어 import 하지 마라 — 화면의 확장과 다른 변경 잠금이
  생긴다. 0개면 설치하거나 켜고, 둘 이상이면 쓸 하나만 남기고 끈다.
- **Scene 명령** — `status` 가 돌아오면 Scene 명령이 있는 확장이다. 이 판의 명령을 다
  아는지까지 보여 주지는 않는다 — 나중에 명령이 `Unknown Scene command` 로 거절되면 그때
  낡은 확장임이 드러난다. `ModuleNotFoundError` 면 Scene 명령이 없는 옛 확장이다. 둘 다
  고치는 법은 같다 — 녹화를 멈추고, 이 MOVIOLA 판에 맞는 `moviola_vcam` 확장 ZIP 을
  Blender 의 Install from Disk 로 설치해 옛 것을 바꾼 뒤, 켜고 다시 돌린다.

본 것은 2번 요약에 한 줄씩 적는다 — 준비됨, 또는 무엇이 빠졌고 무엇을 하면 되는지.

### 2. 추천을 먼저 대고 항목마다 묻는다

찾은 것을 먼저 두세 줄로 요약한다. 그다음 **항목 둘**을 하나씩 — 하나 묻고, 답을 받고,
다음. 각 항목은 **추천을 먼저 대서** 감독이 한 마디로 승낙할 수 있게 한다.

**항목 하나 — 어느 작품인가.**

`list_projects` 가 준 목록을 이름으로 보여주고 고르게 한다. 최근에 고친 것이 위에 온다.

목록에 감독이 하려는 작품이 없으면 **이름을 물어 새로 만든다** — "《…》 라는 이름으로
새로 만들까요?" 승낙하면 `create_project` 를 부른다. 도구가 첫 드래프트를 함께 만들어
주면 그 값을 그대로 적고, 안 만들어 주면 드래프트 칸을 비워 둔다 — **세팅이 드래프트를
따로 만들지는 않는다.**

작품이 정해지면 `list_drafts` 로 지금 쓸 드래프트를 고르게 한다. 하나뿐이면 그것으로
정하고 묻지 않는다.

기록에는 **서버 주소와 project_id 를 함께** 적는다. 작품 이름은 유일하지 않고 서버마다
값이 다르다 — 이름만 적으면 스테이징의 《…》 와 프로덕션의 《…》 를 구분할 수 없다.

**항목 둘 — 폴더를 여기 두나.**

기본은 지금 자리다. 그대로 두면 된다.

감독이 다른 자리를 원하면 경로를 묻고 **거기에 쓴다** — 블록을 든 지시 파일도 같이 그
자리로 간다. 그리고 말한다: 다음부터는 **그 폴더에서 터미널을 켜야** 그 파일이 자동으로
읽힌다.

**여기가 git 저장소 안이면 먼저 그 사실을 말하고 저장소 밖을 권한다.**

> 여기는 git 저장소 `<저장소 뿌리>` 안입니다. 작품 폴더는 저장소 **밖**에 두시길
> 권합니다 — 미공개 작품 내용이 커밋돼 나가는 것은 이 설계에서 유일하게 못 되돌리는
> 사고입니다. 그래도 여기 두시겠습니까?

그래도 여기 두겠다면 **작품 폴더 자신의 `.gitignore`** 에 `moviola/` 한 줄을 넣기로
정한다(없으면 만든다). 저장소 뿌리의 것을 고치지 마라 — 그 저장소의 다른 폴더까지
규칙이 바뀐다. 이미 걸려 있으면 그렇다고만 말하고 두 줄로 만들지 않는다. **실제로 넣는
것은 4번이다.**

### 3. 쓸 것을 보여주고 확인받는다

쓰기 전에 통째로 보여준다.

- 어느 파일을 새로 만들고 어느 파일을 고치는지 — 경로 그대로.
- 옮길 폴더 — `moviola/decisions/` → `moviola/plans/` (해당할 때만).
- 블록을 더할 지시 파일 — 이 클라이언트가 읽는 쪽 — 과 그 블록의 실제 문장. 새로 만들
  파일이면 새로 만든다고, 실린 맥락이 아니라 기본으로 고른 파일이면 그렇다고 적는다.
  블록 속 경로는 그 파일의 폴더 기준으로 쓴다 — `.claude/CLAUDE.md` 면
  `../moviola/project.md` 다.
- `moviola/project.md` 의 실제 내용.
- `.gitignore` 에 넣을 줄 (해당할 때만).
- 서버에서 받아올 파일 — 경로와 크기 그대로. 이미 여기 있어서 **건너뛸 파일**도 함께.
  서버에 아무것도 없으면 "서버에 올라온 것이 없어 **빈 폴더로 시작합니다**"라고 말한다.

감독이 고칠 수 있게 한 뒤에 쓴다.

### 4. 쓰고, 무엇이 이제 이 자리를 읽는지 말한다

**고칠 파일은 이 클라이언트가 읽는 지시 파일이다** — 1번에서 확인한 그 파일.

- 그 파일이 있으면 그것을 고친다.
- 없고 다른 쪽만 있으면 — Codex 인데 `CLAUDE.md` 만 있는 폴더처럼 — 읽히는 쪽을 새로
  만든다. 있던 파일은 그대로 둔다. Claude Code 쪽에 `CLAUDE.md` 를 새로 만들면 그 폴더의
  `AGENTS.md` 는 Claude Code 에 더는 안 읽힌다 — 3번에서 그 사실도 말한다.
- 둘 다 없으면 이 클라이언트가 읽는 쪽을 만든다 — Claude Code 는 `CLAUDE.md`, Codex 는
  `AGENTS.md`.

새로 만드는 것도 3번에서 보여주고 승낙받은 쓰기다 — 따로 다시 묻지 않는다.

`## MOVIOLA` 블록이 이미 있으면 **그 자리에서 갱신한다.** 주변 절은 건드리지 않는다 —
감독이 손으로 고친 것이 그 안에 있다.

감독이 지시 파일에 블록을 두기를 원치 않으면 `moviola/project.md` 만 두고 이렇게 말한다
— "가리키는 자리가 없어서 조연출이 이 폴더를 못 찾을 수 있습니다."

**쓴다.** 씨앗 템플릿에서 시작한다.

- [claude-block.md](./claude-block.md) — `CLAUDE.md` / `AGENTS.md` 에 더할 블록
- [project.md](./project.md) — 작품 카드
- [draft-plan.md](./draft-plan.md) — 씬별 계획 파일. **세팅은 이걸 안 만든다.**
  조연출이 첫 계획을 적을 때 이 모양으로 만든다.

저장소 안이면 **`.gitignore` 를 먼저 고치고 그다음에 `moviola/` 를 쓴다.** 순서가
바뀌면 무시되지 않는 창이 잠깐 열린다. 넣은 뒤 `git check-ignore -q moviola/` 로
실제로 걸리는지 확인하고 **넣었다고 말한다.** 확인 없이 넣었다고 말하지 마라 — 안 걸린
채로 두면 다음 커밋에 작품 내용이 실려 나간다.

**옛 이름 폴더는 이름만 바꾼다.** `moviola/decisions/` 가 있으면 `moviola/plans/` 로
옮긴다 — `mv moviola/decisions moviola/plans`. **안을 열어 고치지 마라.** 계획은 글자
그대로 남아야 한다. 옮긴 뒤 무엇이 어디로 갔는지 말한다. 둘 다 있으면 옮기지 말고 그
사실을 말한다 — `mv` 가 옛 폴더를 새 폴더 **안으로** 넣어 버린다.

**그다음에 서버에 있는 것을 받아 온다.** 옮기기가 먼저다 — 받는 것이 먼저면 `plans/`
가 생겨 옮길 자리가 막힌다. `list_work_files` 가 준 경로마다 `get_work_file` 을 부르고,
받은 글을 `moviola/` 아래 **같은 경로에 글자 그대로** 쓴다 — 줄바꿈도 한글도 손대지
마라. **로컬에 이미 있는 파일은 건너뛴다** — 어느 쪽이 새 것인지 견주는 일은 세팅이
하는 일이 아니다. 받은 파일과 건너뛴 파일을 갈라서 말한다. 받을 것이 하나도 없으면
폴더를 빈 채로 두고 그 사실을 말한다.

**이미 설정된 자리면 덮어쓰지 않고 고친다.** `moviola/project.md` 가 이미 있으면 바뀐
줄만 고치고, 감독이 손으로 더한 절은 그대로 둔다.

**끝나면 말한다.**

- 무엇이 이 자리를 읽는지 — 이 폴더에서 터미널을 켜면 블록을 쓴 지시 파일(이름으로
  말한다)이 이 클라이언트에 자동으로 읽히고, MOVIOLA 작업을 할 때 조연출이
  `moviola/project.md` 를 읽는다.
- 파일은 나중에 직접 고쳐도 된다.
- **다시 돌려야 하는 경우는 넷뿐이다** — ① 작품 폴더를 다른 자리로 옮겼을 때 ② 다른
  서버의 같은 작품으로 갈아탈 때(스테이징 ↔ 프로덕션) ③ 처음부터 다시 잡을 때 ④ 이
  폴더를 다른 클라이언트로 처음 열 때 — 그 클라이언트가 읽는 지시 파일에 블록이 없다.
  드래프트를 새로 만들거나 복제하는 것, 씬이 늘거나 순서가 바뀌는 것은 세팅과
  **무관하다** — 조연출이 `moviola/project.md` 의 '지금 쓰는 draft_id' 줄만 고친다.
