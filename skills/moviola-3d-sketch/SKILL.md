---
name: moviola-3d-sketch
description: Run the MOVIOLA 3D Sketch procedure for one Scene — have the server build or revise its 3D Scene from the Master, frame each Cut from the VCam Still the director chooses or else with the Assistant Director's own camera, and produce the first AI Cut Sketches. A Scene still on an older .blend source continues in local Blender or on the director's Mac worker. Run by name, followed by the Project, Draft, and Scene (and Cuts, if narrowed) to work on.
disable-model-invocation: true
---

# MOVIOLA 3D Sketch

씬 하나를 Master 에서 서버가 짓는 3D Scene 으로 세우고, 감독이 고른 VCam Still 구도나 조연출이 잡은 구도로 첫
AI Sketch 까지 가는 절차를 이름으로 부르는 자리다. 절차는 `moviola-directing` 스킬이 들고 있고, 이
스킬은 그쪽을 가리키기만 한다.

### 1. 조연출 매뉴얼을 끝까지 먼저 읽는다

[../moviola-directing/SKILL.md](../moviola-directing/SKILL.md) 를 끝까지 읽는다. 대상을
잡는 법, 유료 · 삭제 호출 전에 확인받는 법, `skill_version` 같은 안전 규칙이 거기 있다.
그 파일이 없으면 `moviola-directing` 스킬이 안 깔린 것이다 — 멈추고 감독에게 설치를
권한다.

### 2. 3D Sketch 절차를 끝까지 읽는다

[../moviola-directing/references/scene-3d-sketch.md](../moviola-directing/references/scene-3d-sketch.md)
를 끝까지 읽고 그대로 따른다.

### 3. 시작 대상을 잡는다

감독이 명령 뒤에 적은 말에서 Project · Draft · Scene 을, Cut 을 좁혔으면 그 Cut id 까지
잡는다. `list_projects` · `list_drafts` · `get_draft_outline` 으로 찾는다. 맞는 것이
없거나 여럿이면 후보를 보여주고 묻는다. **짐작하지 마라.**
