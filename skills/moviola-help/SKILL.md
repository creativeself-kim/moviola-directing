---
name: moviola-help
description: Answer the director's questions about MOVIOLA in a terminal — is my setup done, where does my Draft stand and what comes next, what do I say to get X done, why is it not working, what changed in the skill — and hand over the one prompt to send next. Changes nothing for a help question. Run by name, followed by the question.
disable-model-invocation: true
---

# MOVIOLA 도움말

감독의 질문에 답하고, 다음에 보낼 프롬프트 하나를 코드 블록으로 건네고, 답을 가져온
파일을 밝힌다. 이 파일은 질문을 그 답을 든 스킬과 문서로 잇는 지도다. 자세한 것은 그
문서가 들고 있다 — 인용하기 전에 읽고, 이 지도와 다르면 그 문서를 믿는다.

**도움 질문에는 아무것도 바꾸지 않는다.** 읽기만 한다 — `list_projects` · `list_drafts`
· `get_draft_outline` · `list_characters` · `get_scene` · `list_work_files`, 로컬 파일
읽기, `git rev-parse` 같은 읽기 전용 셸, 아래가 가리키는 읽기 전용 Blender 확인. MCP 로
만들거나 고치지 않고, 파일을 쓰지 않고, 유료 호출을 하지 않는다. 일은 감독이 건넨
프롬프트를 보낼 때 시작된다.

일을 시키는 말("3번 씬 컷 나눠 줘")은 도움 질문이 아니다.
[../moviola-directing/SKILL.md](../moviola-directing/SKILL.md) 를 읽고 그 아래에서 일한다
— 확인받는 규칙도 그쪽 것이다. `/moviola-help` 없이 그냥 말해도 같다는 것을 한 번만
알린다.

명령은 Claude Code 표기(`/moviola-setup`)로 적었다. Claude Code 는 플러그인 설치여도 이
이름 그대로 불린다. Codex 는 스킬을 `/` 가 아니라 `$` 로 부르고, 설치 방식에 따라 이름이
다르다.

- npx 설치 — `$moviola-setup`.
- 플러그인 설치 — `$moviola-directing:moviola-setup`. 접두어가 빠지면 오류 없이 평문으로
  가서 스킬이 안 불린다.

설치 방식은 이 스킬이 실린 이름과 경로로 안다. 이름이 `moviola-directing:moviola-help` 이거나
이 파일이 `plugins/cache/` 아래에 있으면 플러그인이고, `.agents/skills/` 아래면 npx 다.
가릴 수 없으면 두 꼴을 다 건넨다.

질문이 비었거나 어느 쪽인지 모르겠으면 이 다섯 중 무엇인지 한 번 묻는다.

- 세팅이 됐나?
- 지금 어디고 다음은?
- 이럴 땐 뭐라고 말하지?
- 잘 안 돼
- 뭐가 바뀌었어?

## 세팅이 됐나?

넷을 본다. 빠진 것만 고치는 법과 함께 알리고, 다 됐으면 한 줄로 됐다고 한다.

- **MOVIOLA MCP** — MOVIOLA 도구가 이 세션에 광고되고 `list_projects` 가 읽히나.
- **스킬** — [moviola-directing](../moviola-directing/SKILL.md) ·
  [moviola-setup](../moviola-setup/SKILL.md) ·
  [moviola-3d-sketch](../moviola-3d-sketch/SKILL.md) ·
  [moviola-review](../moviola-review/SKILL.md) 가 옆에 깔렸나. 설치된 판은
  `moviola-directing/SKILL.md` 첫머리의 `Skill version` 값이다.
- **작품 폴더** — `/moviola-setup` 을 돌렸나. 이 클라이언트가 읽은 지시 파일에
  `## MOVIOLA` 블록이 있고, `moviola/project.md` 가 있고, 그 서버 줄이 지금 붙은 MCP
  주소와 맞나.
- **Blender** — 3D 씬을 이 컴퓨터에서 만들 때만. Blender 실행기가 붙었고 켜진
  `moviola_vcam` 이 하나인가.

무엇을 어떻게 보는지는 [moviola-setup 1. 살핀다](../moviola-setup/SKILL.md#1-살핀다)에
있다. 그 절의 읽기만 하고 2번 앞에서 멈춘다 — 쓰는 것은 세팅의 일이다. 빠진 것이 연결이나
설치면 '잘 안 돼' 표의 그 줄을, 작품 폴더면 `/moviola-setup` 을 건넨다.

## 지금 어디고 다음은?

1. Project · Draft 를 잡는다. `moviola/project.md` 가 있으면 거기 적힌 것을, 없으면
   `list_projects` · `list_drafts` 로 찾는다. 그럴듯한 것이 여럿이면 후보를 보여주고
   묻는다. **짐작하지 마라.**
2. `get_draft_outline` 을 부른다. `skill_version` 은 설치된 판이다.
3. 그 결과를 조연출 매뉴얼의
   [Locate the Draft on the pipeline](../moviola-directing/SKILL.md#locate-the-draft-on-the-pipeline)
   절에 비춰 읽는다. 단계를 가르는 기준은 그 절에만 있다.
4. Scene 마다 어느 단계에 있고 그 위 단계가 무엇을 기다리는지 말한 뒤, 다음에 보낼
   프롬프트 하나를 준다.

## 이럴 땐 뭐라고 말하지?

| 하고 싶은 일 | 들어갈 곳 | 예시 프롬프트 |
|---|---|---|
| 작품 폴더 잡기, 새 컴퓨터에서 이어 하기 | [`/moviola-setup`](../moviola-setup/SKILL.md) | `/moviola-setup` |
| 씬 · 컷 쓰기와 고치기 | [authoring-and-editing.md](../moviola-directing/references/authoring-and-editing.md) | 3번 씬을 컷으로 나눠 줘 |
| 인물 외형 · 의상 · Portrait · Plate | [characters-and-assets.md](../moviola-directing/references/characters-and-assets.md) | 민서 의상을 겨울 코트로 바꾸고 Portrait 후보를 보여 줘 |
| 다른 영화의 컷 리듬 빌리기 | [directing-samples.md](../moviola-directing/references/directing-samples.md) | 2번 씬에 맞는 컷 리듬 표본을 찾아 줘 |
| 2D 스케치 | [storyboards.md](../moviola-directing/references/storyboards.md) | 1번 씬 보드를 2D 스케치로 만들어 줘 |
| 3D 씬과 첫 스케치 | [`/moviola-3d-sketch`](../moviola-3d-sketch/SKILL.md) | `/moviola-3d-sketch 4번 씬` |
| 다시 그리기 · 확정 렌더 | [renders.md](../moviola-directing/references/renders.md) | 2번 씬 5번 컷만 다시 그려 줘 |
| 색 | [color.md](../moviola-directing/references/color.md) | 이 작품의 기준 그림 후보를 추천해 줘 |
| 클립 · 애니매틱 | [animatics.md](../moviola-directing/references/animatics.md) | 1번 씬 컷들을 클립으로 만들어 줘 |
| 리뷰 | [`/moviola-review`](../moviola-review/SKILL.md) | `/moviola-review 3번 씬` |

`/` 로 시작하는 진입 스킬은 그대로 친다. Codex 에서는 `/` 대신 `$` 고, 플러그인 설치면
`$moviola-directing:` 을 앞에 붙인다(위 규칙). 나머지는 평소 말로 보내면 조연출 매뉴얼이 스스로 열려 그 문서를 읽는다. 예시는 감독의 작품 · 씬 · 인물 이름으로 바꿔 준다.

## 잘 안 돼

| 증상 | 까닭 | 할 일 |
|---|---|---|
| MOVIOLA 도구가 안 보인다 | 연결이 안 됐거나, 연결한 뒤 세션을 안 열었다 | Claude Code 는 `claude mcp list` 나 세션 안의 `/mcp`, Codex 는 `codex mcp list` 나 `codex mcp get moviola` 로 본다. 연결한 뒤에는 세션을 새로 연다 |
| `401` | 토큰이 만료되거나 폐기됐다 | MOVIOLA 웹 설정 → 터미널 토큰에서 새로 발급해 `MOVIOLA_PAT` 만 바꾼다 |
| 지난 터미널에선 됐는데 여기선 안 된다 | `MOVIOLA_PAT` 은 셸마다 따로다 | `export` 를 셸 프로필에 넣는다 |
| 등록은 됐는데 안 된다 | 등록이 꼬였다 | Claude Code 는 `claude mcp remove moviola --scope user` 뒤 다시 `claude mcp add`, Codex 는 `codex mcp remove moviola` 뒤 다시 `codex mcp add` |
| 표본 조건 검색이나 컷 리듬 추천 도구가 없다 | 이 연결의 도구 목록(profile)에 없다. MCP 안내의 `[이 연결의 도구 목록]` 줄이 어느 쪽인지 말한다 | `X-Moviola-Profile` 헤더에 `advanced`(`search_directing_samples` · `list_directing_samples`) 또는 `recommend`(`recommend_cut_rhythm`)를 넣고 다시 붙는다. `recommend` 라면 Claude Code 는 MCP 설정의 `headers` 에 `"X-Moviola-Profile": "recommend"`, Codex 는 `config.toml` 의 `[mcp_servers.moviola]` 아래 `http_headers = { "X-Moviola-Profile" = "recommend" }` 다. Codex 는 `headers` 키를 경고 없이 버린다 |
| 서버가 스킬이 없다거나 낡았다고 한다 | 스킬이 안 깔렸거나 옛 판이다 | `npx skills add creativeself-kim/moviola-directing --skill '*' --agent claude-code cursor codex --global --yes` 를 다시 돌린다. 플러그인으로 깔았으면 `claude plugin update moviola-directing@moviola`, Codex 는 `codex plugin marketplace upgrade` 뒤 `codex plugin add moviola-directing@moviola` |
| 명령이 안 불린다, Codex 에서 `Unrecognized command`, Codex 가 명령을 평문으로 받는다 | Codex 는 스킬을 `/` 가 아니라 `$` 로 부른다. Codex 플러그인 설치에서 `moviola-directing:` 접두어 없이 부르면 오류 없이 평문으로 간다. 아니면 스킬이 다 안 깔렸다 | Codex 는 `$moviola-help` 로 부른다. 플러그인이면 `/moviola-directing:moviola-help`(Codex 는 `$moviola-directing:moviola-help`). 그래도 없으면 위 설치 명령을 다시 돌리고 세션을 새로 연다 |
| Blender 실행기가 없다, 켜진 `moviola_vcam` 이 0개 · 둘 이상, `Unknown Scene command`, `ModuleNotFoundError` | 로컬 Blender 쪽 준비가 덜 됐다 | [moviola-setup 1. 살핀다](../moviola-setup/SKILL.md#1-살핀다)의 Blender 쪽 준비를 따른다 |
| 도구는 되는데 규약을 안 따른다 | MCP 연결과 스킬은 따로 깐다 | 위 설치 명령으로 스킬을 깐다 |

## 뭐가 바뀌었어?

1. 설치된 판을 [moviola-directing](../moviola-directing/SKILL.md) 첫머리의
   `Skill version` 에서 읽는다.
2. 공개 저장소의 Release 를 읽는다. 태그는 `v<판>` 이다. `gh` 가 있으면
   `gh release list --repo creativeself-kim/moviola-directing` 과 `gh release view`, 없으면
   `curl -s "https://api.github.com/repos/creativeself-kim/moviola-directing/releases?per_page=50"`.
3. 판은 자리마다 숫자로 견준다 — `0.1.10` 이 `0.1.9` 보다 새것이다. 설치된 판보다 새
   Release 가 있으면 최신부터 그 본문을 감독의 말로 줄여 보여 주고, 업데이트는 '잘 안 돼'
   표의 스킬 줄을 가리킨다. 없으면 최신이라고 말하고 멈춘다. 설치된 판이 공개 Release 보다
   높으면 공개본보다 앞선 판이라고 말한다.
