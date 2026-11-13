---
name: moviola-review
description: Review a MOVIOLA Draft without editing its Scenes or Cuts — critique its Scenes, Cuts, boards, and clips against what was agreed, and propose Cut-level alternatives. A paid clip review runs only after the director confirms it. Run by name, followed by the Project, Draft, and Scene to review.
disable-model-invocation: true
---

# MOVIOLA 리뷰

Scene · Cut 을 고치지 않고 보고 평하는 리뷰 절차를 이름으로 부르는 자리다. 절차는
`moviola-directing` 스킬이 들고 있고, 이 스킬은 그쪽을 가리키기만 한다.

**이 명령 안에서는 Scene · Cut 을 바꾸는 도구를 부르지 않는다.** 대안은 Cut 단위의
before/after 로 내고 멈춘다. 그중 하나를 적용하라는 말은 리뷰가 끝난 뒤의 새 지시다.

**`review_clips` 는 감독이 확인한 뒤에만 부른다.** 유료이고, 리뷰 결과를 클립 리뷰
기록으로 남긴다 — Draft 개요의 미검증 클립 수도 그만큼 준다. 부르기 전에 대상 Cut 과
규모(예상 비용)를 말하고 확인을 받는다. 이미 남은 리뷰는 `list_clips` 로 공짜로 읽는다.
그 밖에는 읽는 도구만 쓴다.

### 1. 조연출 매뉴얼을 끝까지 먼저 읽는다

[../moviola-directing/SKILL.md](../moviola-directing/SKILL.md) 를 끝까지 읽는다. 대상을
잡는 법, 유료 호출 전에 확인받는 법, `skill_version` 같은 안전 규칙이 거기 있다. 그
파일이 없으면 `moviola-directing` 스킬이 안 깔린 것이다 — 멈추고 감독에게 설치를 권한다.

### 2. 리뷰 절차를 끝까지 읽는다

[../moviola-directing/references/review.md](../moviola-directing/references/review.md) 를
끝까지 읽고 그대로 따른다. SKILL.md 의 갈래 표가 리뷰에 붙이는 문서도 읽는다 —
[directing-rules.md](../moviola-directing/references/directing-rules.md), 그리고 장르가
정해져 있을 때만 그 장르 가이드 하나.

### 3. 시작 대상을 잡는다

감독이 명령 뒤에 적은 말에서 Project · Draft · Scene 을 잡는다. `list_projects` ·
`list_drafts` · `get_draft_outline` 으로 찾는다. 맞는 것이 없거나 여럿이면 후보를
보여주고 묻는다. **짐작하지 마라.**
