-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
-- 한국어. Complete: same keys as frFR and enUS. Tone: short, dictionary form, like the Korean WoW UI.
-- Tokens (%s, %d, %1$s, |cffRRGGBB, |r) are kept as in enUS. Korean has no letter case: *_caps keys use the normal text.
-- Korean has a single plural form: .one and .other carry the same text. The Legacy tree keeps its original key prefix, only the displayed word is 유산.
local ADDON_NAME, AF = ...

AF:RegisterLocale("koKR", {
  -- core
  ["core.loaded"] = "로드됨%s. |cffffd100/af|r 를 입력하거나 미니맵 버튼을 클릭하면 애드온이 열립니다.",
  ["core.ui_missing"] = "인터페이스가 로드되지 않았습니다.",

  -- path
  ["path.err.empty"] = "경로가 비어 있거나 잘렸습니다.",
  ["path.err.version"] = "알 수 없는 경로 버전입니다.",
  ["path.err.header"] = "경로 머리말이 올바르지 않습니다.",
  ["path.err.too_long"] = "경로가 너무 깁니다 (%d포인트 초과).",
  ["path.err.char"] = "경로에 올바르지 않은 문자가 있습니다.",
  ["path.err.unknown_talent"] = "이 경로에 알 수 없는 특성이 있습니다.",
  ["path.err.maxed"] = "%s 특성은 이미 최대 등급(%d)입니다.",
  ["path.err.cap"] = "%d포인트 한도에 도달했습니다.",
  ["path.err.other_talent"] = "다른 특성",
  ["path.err.prereq"] = "%s 특성에는 %s %d등급이 필요합니다.",
  ["path.err.tier"] = "%s 특성에는 %d포인트가 필요합니다 (%s 트리, 경로상 현재 %d포인트).",
  ["path.err.cannot_remove"] = "%s 특성을 제거할 수 없습니다: %s",

  -- talents
  ["talents.err.class_unknown"] = "알 수 없는 직업입니다.",
  ["talents.err.talent_unknown"] = "알 수 없는 특성입니다.",
  ["talents.count"] = "특성 %d개",
  ["talents.head_sub"] = "%s · %s, 신규 %d개, 변경 %d개",
  ["talents.client_data"] = "클라이언트 데이터 %s",

  -- apply
  ["apply.err.unreadable"] = "게임 내 특성을 읽을 수 없습니다: /af diag 를 입력하세요.",
  ["apply.err.not_found"] = "클라이언트에서 %s 특성을 찾을 수 없습니다.",
  ["apply.err.not_learnable"] = "%s 특성은 아직 배울 수 없습니다 (선행 조건 또는 트리 포인트).",
  ["apply.info.nothing_to_apply_learned"] = "적용할 내용이 없습니다: 빌드를 이미 게임에서 배웠습니다.",
  ["apply.err.cannot_unlearn"] = "게임에서는 배운 포인트 하나만 취소할 수 없습니다",
  ["apply.err.combat"] = "전투 중에는 할 수 없습니다.",
  ["apply.err.locked"] = "지금은 특성을 변경할 수 없습니다.",
  ["apply.err.no_points"] = "이 캐릭터에 사용 가능한 특성 포인트가 없습니다.",
  ["apply.err.no_more_points"] = "나머지 빌드에 사용할 포인트가 없습니다.",
  ["apply.err.refused"] = "게임이 %s 을(를) 거부했습니다.",
  ["apply.err.nothing"] = "적용할 내용이 없습니다.",
  ["apply.err.not_validated"] = "게임이 특성을 확인하지 않았습니다.",
  ["apply.err.none_learned"] = "게임에서 배운 빌드 포인트가 없습니다.",
  ["apply.err.refused_remove"] = "게임이 %s 의 제거를 거부했습니다.",
  ["apply.ok.removed"] = "게임에서 제거됨: %s.",
  ["apply.err.timeout"] = "게임이 요청한 특성을 배우지 않았습니다.",
  ["apply.warn.learned.one"] = "%d포인트 배움. %s",
  ["apply.warn.learned.other"] = "%d포인트 배움. %s",
  ["apply.ok.build_applied"] = "게임에 빌드를 적용했습니다: %d포인트 배움.",
  ["apply.ok.learned"] = "게임에서 배움: %s.",

  -- share
  ["share.err.empty_any"] = "AF1-(직업) 또는 AF1H-(유산)로 시작하는 코드를 붙여넣으세요.",
  ["share.err.not_af_any"] = "Azeroth Forever 코드가 아닙니다: AF1- 또는 AF1H- 로 시작해야 합니다.",
  ["share.err.incomplete"] = "코드가 불완전합니다: 마지막 2글자까지 전체를 복사하세요.",
  ["share.err.corrupt"] = "손상된 코드입니다 (체크섬 오류): 전체를 복사하세요.",
  ["share.err.kind"] = "알 수 없는 코드 유형입니다.",
  ["share.err.class_in_code"] = "이 코드에 알 수 없는 직업이 있습니다.",
  ["share.err.empty_class"] = "AF1- 로 시작하는 코드를 붙여넣으세요.",
  ["share.err.is_heritage"] = "유산 코드입니다: 유산 탭에서 읽으세요.",
  ["share.err.not_af_class"] = "Azeroth Forever 코드가 아닙니다: AF1- 로 시작해야 합니다.",
  ["share.err.class_or_catalog"] = "이 코드에 알 수 없는 직업이 있거나 특성 목록이 다릅니다: 애드온을 업데이트하세요.",
  ["share.err.catalog_changed"] = "특성 목록이 변경되었습니다: 애드온을 업데이트하세요 (%s)",
  ["share.err.impossible_order"] = "이 코드는 불가능한 순서를 나타냅니다 (%d단계): %s",
  ["share.export_error"] = "내보낼 수 없습니다: %s",
  ["share.copy_link"] = "링크 복사",
  ["share.link_help_build"] = "이 페이지 링크 (빌드 + 포인트 순서)",
  ["share.copy_code"] = "애드온 코드 복사",
  ["share.code_help_class"] = "애드온 또는 사이트에 붙여넣을 AF1- 코드",
  ["share.code_title"] = "애드온 코드",
  ["share.paste"] = "코드 붙여넣기",
  ["share.paste_menu_help"] = "AF1- 코드(직업) 또는 AF1H- 코드(유산)",
  ["share.paste_popup_help"] = "AF1-(직업) 또는 AF1H-(유산) 코드를 붙여넣고 가져오기를 누르세요.",
  ["share.public_help"] = "Ctrl+C 로 복사한 뒤 브라우저에서 링크를 여세요.",
  ["share.public_title"] = "공개 빌드 %s",

  -- heritage
  ["heritage.err.is_class"] = "유산 코드가 아니라 직업 코드(AF1-)입니다.",
  ["heritage.err.version"] = "알 수 없는 유산 코드 버전입니다: 사이트를 업데이트하세요.",
  ["heritage.err.unreadable"] = "읽을 수 없는 유산 코드입니다 (%d등급, 필요 %d등급).",
  ["heritage.err.rank_max"] = "%s 은(는) %d등급을 넘을 수 없습니다.",
  ["heritage.err.too_many"] = "이 코드는 유산 포인트를 %d개보다 많이 사용합니다.",
  ["heritage.err.tiers"] = "이 코드는 트리 포인트 단계를 지키지 않습니다.",
  ["heritage.err.node_unknown"] = "알 수 없는 노드입니다.",
  ["heritage.err.cap"] = "유산 한도 %d포인트에 도달했습니다.",
  ["heritage.err.tier_locked"] = "%s 의 단계에 아직 도달하지 못했습니다.",
  ["heritage.err.preset_invalid"] = "올바르지 않은 프리셋입니다.",
  ["heritage.err.preset_unknown"] = "알 수 없는 프리셋입니다.",
  ["heritage.title"] = "유산 트리",
  ["heritage.sub"] = "전문 기술 · 모험 · 독창성 · %s",
  ["heritage.total_points"] = "%d포인트",
  ["heritage.stat.spent_caps"] = "사용한 포인트",
  ["heritage.stat.left_caps"] = "남은 포인트",
  ["heritage.reset_done"] = "유산을 초기화했습니다.",
  ["heritage.view_at"] = "사용 포인트 %s 일 때의 내 유산 빌드 보기",
  ["heritage.unknown_skill"] = "알 수 없는 기술",
  ["heritage.unknown_skill_hint"] = "향후 업데이트에서 추가됩니다.",
  ["heritage.tip.rank_meta"] = "%d/%d등급 · %s",
  ["heritage.tip.passive"] = "지속 효과",
  ["heritage.tip.at_points"] = "%d포인트 사용 시: %d/%d등급",
  ["heritage.tip.requires"] = "%s 에 유산 포인트 %d 사용 필요.",
  ["heritage.imported"] = "유산을 가져왔습니다 (%d포인트).",
  ["heritage.link_help"] = "이 페이지 링크 (?hbuild=)",
  ["heritage.code_help"] = "애드온 또는 사이트에 붙여넣을 AF1H- 코드",
  ["heritage.talented_note"] = "직업 특성은 9레벨에 시작합니다.",
  ["heritage.tree.professions"] = "전문 기술",
  ["heritage.col.professions.sub"] = "제작, 채집, 골드.",
  ["heritage.node.travail-acharne.name"] = "근면 성실",
  ["heritage.node.travail-acharne.desc"] = "주요, 보조 또는 직업 전문 기술을 사용할 때 숙련도를 얻을 확률이 4% 증가합니다.",
  ["heritage.node.marchandage.name"] = "흥정",
  ["heritage.node.marchandage.desc"] = "모든 상인에게서 아이템을 구매할 때의 골드 가격이 5% 감소합니다.",
  ["heritage.node.chef-etoile.name"] = "별점 요리사",
  ["heritage.node.chef-etoile.desc"] = "요리 제조법에 10% 확률로 추가 결과물이 생성됩니다.",
  ["heritage.node.etude-assidue.name"] = "꾸준한 연구",
  ["heritage.node.etude-assidue.desc"] = "현재 주요 및 보조 전문 기술 중 가장 낮은 숙련도를 1 올립니다. 두 주요 전문 기술과 세 보조 전문 기술이 모두 이미 300에 도달했다면 무작위 원소 정수를 2~4개 얻습니다.",
  ["heritage.node.etude-assidue.meta"] = "25초 시전, 23시간 재사용 대기시간",
  ["heritage.node.recolte-abondante.name"] = "풍성한 수확",
  ["heritage.node.recolte-abondante.desc"] = "채광, 약초 채집, 가죽 손질에서 고급 재료를 20% 더 많이 찾습니다.",
  ["heritage.node.prime-de-rendement.name"] = "수확 보너스",
  ["heritage.node.prime-de-rendement.desc"] = "아제로스 상업 관리국 또는 듀로타 물류에 상자를 배달할 때 5% 확률로 상인의 호의를 100% 더 받습니다.",
  ["heritage.node.maitre-appateur.name"] = "미끼의 달인",
  ["heritage.node.maitre-appateur.desc"] = "미끼를 사용해 낚시할 때 25% 확률로 물고기를 한 마리 더 낚습니다.",
  ["heritage.tree.adventure"] = "모험",
  ["heritage.col.adventure.sub"] = "진행, 탐험, 편의 기능.",
  ["heritage.node.haute-vigilance.name"] = "높은 경계",
  ["heritage.node.haute-vigilance.desc"] = "레벨이 1 높은 것처럼 주변의 은신한 대상을 감지하는 능력이 증가합니다. 전장에서는 효과가 없습니다.",
  ["heritage.node.bien-repose.name"] = "충분한 휴식",
  ["heritage.node.bien-repose.desc"] = "휴식 경험치가 4% 더 빨리 쌓이고 최대치가 4% 증가합니다.",
  ["heritage.node.talentueux.name"] = "재능 있는 자",
  ["heritage.node.talentueux.desc"] = "10레벨 대신 9레벨부터 레벨마다 특성 포인트를 얻으며, 총 특성 포인트는 51을 넘지 않습니다.",
  ["heritage.node.frisson-aventure.name"] = "모험의 전율",
  ["heritage.node.frisson-aventure.desc"] = "하찮지 않은 적에게 결정타를 날릴 때마다 10초에 걸쳐 최대 생명력과 마나의 1%를 회복합니다. 던전, 공격대, 전장에서는 효과가 없습니다.",
  ["heritage.node.guide-de-terrain.name"] = "야외 안내서",
  ["heritage.node.guide-de-terrain.desc"] = "야영지 요소를 추가하는 재사용 대기시간이 8% 감소합니다.",
  ["heritage.node.grand-voyageur.name"] = "노련한 여행자",
  ["heritage.node.grand-voyageur.desc"] = "모든 비행 경로가 50% 할인되고 비행 탈것이 20% 더 빠르게 날아갑니다.",
  ["heritage.node.medecine-de-terrain.name"] = "야전 의학",
  ["heritage.node.medecine-de-terrain.desc"] = "붕대를 사용할 때 \"최근에 붕대를 감음\" 효과의 지속시간이 5초 감소합니다. 던전, 공격대, 전장에서는 효과가 없습니다.",
  ["heritage.tree.ingenuity"] = "독창성",
  ["heritage.col.ingenuity.sub"] = "유지, 평판, 명예.",
  ["heritage.node.pour-un-plus-grand-honneur.name"] = "더 큰 명예를 위해",
  ["heritage.node.pour-un-plus-grand-honneur.desc"] = "획득하는 명예 점수가 2% 증가합니다.",
  ["heritage.node.gourmet.name"] = "미식가",
  ["heritage.node.gourmet.desc"] = "음식으로 얻는 이로운 효과의 지속시간이 33% 증가합니다.",
  ["heritage.node.permanence.name"] = "지속성",
  ["heritage.node.permanence.desc"] = "직업 능력이 파티 또는 공격대에 부여하는 지속시간이 긴 능력치 보너스와 야영지에서 휴식하여 얻는 효과의 지속시간이 50% 증가합니다.",
  ["heritage.node.les-vifs-et-les-morts.name"] = "산 자와 죽은 자",
  ["heritage.node.les-vifs-et-les-morts.desc"] = "죽은 상태에서 이동 속도가 5% 증가하며, 부활한 뒤 1분 동안 또는 전투에 들어갈 때까지 이로운 주문과 능력에 자원이 소모되지 않습니다.",
  ["heritage.node.economie-de-reactifs.name"] = "시약 절약",
  ["heritage.node.economie-de-reactifs.desc"] = "직업 능력에 상인에게서 구매할 수 있는 시약이 더 이상 필요하지 않으며, 1등급 야영지 요소는 제작에 시약이 들지 않습니다.",
  ["heritage.node.renforcement.name"] = "보강",
  ["heritage.node.renforcement.desc"] = "죽을 때 내구도가 8% 덜 감소합니다.",
  ["heritage.node.diplomate.name"] = "외교관",
  ["heritage.node.diplomate.desc"] = "평판 획득량이 2% 증가합니다.",

  -- tab
  ["tab.talents"] = "특성",
  ["tab.heritage"] = "유산",
  ["tab.dungeons"] = "던전 및 공격대",

  -- faction
  ["faction.alliance_caps"] = "얼라이언스",
  ["faction.horde_caps"] = "호드",
  ["faction.alliance"] = "얼라이언스",
  ["faction.horde"] = "호드",
  ["faction.both"] = "중립",

  -- ui
  ["ui.err_section"] = "인터페이스 오류 (%s): %s",
  ["ui.err"] = "인터페이스 오류: %s",
  ["ui.tagline"] = "WOW FOREVER 도구",
  ["ui.close"] = "닫기 (Esc)",
  ["ui.site_tip"] = "복사할 사이트 링크",
  ["ui.site_title"] = "Azeroth Forever 웹사이트",
  ["ui.site_hint"] = "Ctrl+C 로 링크를 복사한 뒤 브라우저에 붙여넣으세요.",

  -- cmd
  ["cmd.scale"] = "창 크기: %s",
  ["cmd.diag_saved"] = "/reload 후 진단 정보가 SavedVariables\\AzerothForever.lua 에 저장됩니다.",
  ["cmd.debug"] = "디버그 모드: %s",
  ["cmd.help"] = "명령어: /af, /af talents, /af legacy, /af dungeons, /af scale 0.8, /af diag, /af survey, /af loot, /af minimap, /af locale, /af debug",
  ["cmd.locale_current"] = "사용 중인 언어: %s (클라이언트: %s). 변경: /af locale frFR, /af locale auto.",
  ["cmd.locale_set"] = "언어: %s. /reload 를 입력하면 적용됩니다.",
  ["cmd.locale_auto"] = "자동 언어 (%s). /reload 를 입력하면 적용됩니다.",
  ["cmd.locale_bad"] = "알 수 없는 언어: %s. 사용 가능한 값: %s.",
  -- language picker (header)
  ["lang.button_tip"] = "애드온 언어",
  ["lang.auto"] = "게임 언어",
  ["lang.auto_help"] = "현재: %s",
  ["lang.need_client"] = "이 언어의 게임 클라이언트 필요 (글꼴)",
  ["lang.reload_confirm"] = "선택한 언어: %s. 인터페이스를 다시 불러오면 적용됩니다. 지금 다시 불러오시겠습니까?",
  ["lang.reload"] = "다시 불러오기",
  ["lang.frFR"] = "프랑스어",
  ["lang.enUS"] = "영어",
  ["lang.deDE"] = "독일어",
  ["lang.esES"] = "스페인어(스페인)",
  ["lang.esMX"] = "스페인어(멕시코)",
  ["lang.itIT"] = "이탈리아어",
  ["lang.koKR"] = "한국어",
  ["lang.jaJP"] = "일본어",

  -- state
  ["state.on"] = "활성화",
  ["state.off"] = "비활성화",
  ["state.done"] = "완료",
  ["state.log"] = "진행 중",
  ["state.avail"] = "수행 가능",
  ["state.locked"] = "수행 불가",
  ["state.done_caps"] = "완료",
  ["state.log_caps"] = "진행 중",
  ["state.avail_caps"] = "수행 가능",
  ["state.locked_caps"] = "수행 불가",

  -- minimap
  ["minimap.tip.left"] = "왼쪽 클릭: 열기 / 닫기",
  ["minimap.tip.right"] = "오른쪽 클릭: 던전 및 공격대",
  ["minimap.tip.drag"] = "드래그: 버튼 이동",
  ["minimap.tip.cmd"] = "/af minimap: 숨기기 / 표시",
  ["minimap.hidden"] = "미니맵 버튼을 숨겼습니다. 다시 표시하려면 /af minimap 을 입력하세요.",
  ["minimap.shown"] = "미니맵 버튼을 표시했습니다.",

  -- common
  ["common.close"] = "닫기",
  ["common.import"] = "가져오기",
  ["common.cancel"] = "취소",
  ["common.ok"] = "확인",
  ["common.confirm"] = "확인 요청",
  ["common.lvl"] = "레벨 %s",
  ["common.lvl_lower"] = "레벨 %s",
  ["common.level_n"] = "레벨 %s",
  ["common.required_n"] = "필요 %s",
  ["common.show"] = "표시",

  -- popup
  ["popup.copy_help"] = "Ctrl+C 로 복사, Esc 로 닫기.",
  ["popup.code_unreadable"] = "읽을 수 없는 코드입니다.",

  -- status
  ["status.new"] = "신규",
  ["status.changed"] = "변경됨",
  ["status.unchanged"] = "동일 확인됨",

  -- mode
  ["mode.final"] = "60레벨 빌드",
  ["mode.path"] = "레벨별 빌드",
  ["mode.final_hint"] = "60레벨 빌드: 최종 포인트를 배치하면 레벨업 순서는 자동으로 계산됩니다.",
  ["mode.path_hint"] = "레벨별 빌드: 클릭할 때마다 레벨업하면서 찍을 다음 포인트가 됩니다.",

  -- badge
  ["badge.changed_from_classic"] = "클래식에서 변경됨",
  ["badge.new_in_forever"] = "포에버 신규",

  -- stat
  ["stat.spent_caps"] = "사용한 포인트",
  ["stat.left_caps"] = "남은 포인트",
  ["stat.level_required_caps"] = "요구 레벨",
  ["stat.available_caps"] = "사용 가능",
  ["stat.spent_short_caps"] = "사용",

  -- btn
  ["btn.public_builds"] = "공개 빌드",
  ["btn.public_builds_class"] = "공개 빌드 %s",
  ["btn.share"] = "공유",
  ["btn.save"] = "저장",
  ["btn.reset"] = "초기화",
  ["btn.view_order"] = "포인트 순서 보기",
  ["btn.automatic"] = "자동",
  ["btn.automatic_tip"] = "레벨업할 때마다 다음 빌드 포인트를 게임에 적용합니다",
  ["btn.sync"] = "동기화",
  ["btn.sync_tip"] = "빌드를 이 캐릭터가 배운 특성으로 바꿉니다",
  ["btn.undo"] = "되돌리기",
  ["btn.undo_tip"] = "게임에서 마지막으로 배운 포인트를 제거합니다",
  ["btn.apply_all"] = "모든 포인트 적용",
  ["btn.apply_all_tip"] = "모든 빌드 포인트를 게임에 적용합니다",
  ["btn.apply_next"] = "다음 포인트 적용",
  ["btn.apply_next_tip"] = "다음 빌드 포인트를 게임에 적용합니다",
  ["btn.apply"] = "적용",

  -- toggle
  ["toggle.classic_version"] = "클래식 버전",

  -- planner
  ["planner.view_at_level"] = "%s레벨일 때의 내 빌드 보기",

  -- tree
  ["tree.reset_tip"] = "이 트리 초기화",
  ["tree.pts"] = "%d포인트",
  ["tree.pts_at"] = "%d/%d포인트",
  ["tree.warrior.arms"] = "무기",
  ["tree.warrior.fury"] = "분노",
  ["tree.warrior.protection"] = "방어",
  ["tree.paladin.holy"] = "신성",
  ["tree.paladin.protection"] = "보호",
  ["tree.paladin.retribution"] = "징벌",
  ["tree.hunter.beast_mastery"] = "야수",
  ["tree.hunter.marksmanship"] = "사격",
  ["tree.hunter.survival"] = "생존",
  ["tree.rogue.assassination"] = "암살",
  ["tree.rogue.combat"] = "전투",
  ["tree.rogue.subtlety"] = "잠행",
  ["tree.priest.discipline"] = "수양",
  ["tree.priest.holy"] = "신성",
  ["tree.priest.shadow"] = "암흑",
  ["tree.shaman.elemental"] = "정기",
  ["tree.shaman.enhancement"] = "고양",
  ["tree.shaman.restoration"] = "복원",
  ["tree.mage.arcane"] = "비전",
  ["tree.mage.fire"] = "화염",
  ["tree.mage.frost"] = "냉기",
  ["tree.warlock.affliction"] = "고통",
  ["tree.warlock.demonology"] = "악마",
  ["tree.warlock.destruction"] = "파괴",
  ["tree.druid.balance"] = "조화",
  ["tree.druid.feral"] = "야성",
  ["tree.druid.restoration"] = "회복",

  -- order
  ["order.title"] = "포인트 순서",
  ["order.empty"] = "배치한 포인트가 없습니다. 특성을 클릭해 시작하세요.",

  -- footer
  ["footer.in_game_caps"] = "게임 내",

  -- toast
  ["toast.build_cleared"] = "%s 빌드를 비웠습니다.",
  ["toast.this_class"] = "이 직업",
  ["toast.other_class"] = "다른 직업을 보고 있습니다: 게임에서 적용하려면 자신의 직업으로 돌아가세요.",
  ["toast.synced.one"] = "빌드 동기화됨: 게임에서 %d포인트 배움.",
  ["toast.synced.other"] = "빌드 동기화됨: 게임에서 %d포인트 배움.",
  ["toast.build_imported"] = "빌드를 가져왔습니다: %s.",
  ["toast.point_tomtom"] = "TomTom 지점 설정됨: %s.",
  ["toast.point_map"] = "지도 표시 설정됨: %s.",
  ["toast.point_unknown"] = "%s 의 위치를 알 수 없습니다.",

  -- confirm
  ["confirm.apply_all"] = "지금 모든 빌드 포인트를 게임에 적용하시겠습니까?",

  -- save
  ["save.title"] = "빌드 저장",
  ["save.list_caps"] = "이 계정에 저장된 빌드",
  ["save.empty"] = "이 직업에 저장된 빌드가 없습니다.",
  ["save.err.name"] = "빌드 이름을 입력하세요.",
  ["save.err.empty"] = "빌드가 비어 있습니다: 저장할 내용이 없습니다.",
  ["save.ok"] = "빌드 \"%s\" 을(를) 저장했습니다.",
  ["save.btn_delete"] = "삭제",
  ["save.btn_load"] = "불러오기",
  ["save.row_meta"] = "%d포인트 · %s",
  ["save.err.unreadable"] = "현재 데이터로는 이 빌드를 읽을 수 없습니다: %s",
  ["save.loaded"] = "빌드 \"%s\" 을(를) 불러왔습니다.",

  -- tip
  ["tip.rank"] = "%d/%d등급",
  ["tip.next_rank_caps"] = "다음 등급",
  ["tip.classic_caps"] = "클래식",
  ["tip.at_level"] = "%d레벨: %d/%d등급",
  ["tip.next_rank_classic"] = "다음 등급 (클래식): %s",
  ["tip.requires_tree_points"] = "이 트리에 %d포인트 필요.",
  ["tip.requires_rank"] = "%s (%d등급)",
  ["tip.requires_list"] = "필요: %s",
  ["tip.learned_in_game"] = "게임에서 배움: %d/%d",
  ["tip.click_learn"] = "클릭: 배우기 · 오른쪽 클릭: 취소",

  -- preset
  ["preset.leveling"] = "모험",
  ["preset.metiers"] = "전문 기술",
  ["preset.qdv60"] = "독창성",
  ["preset.applied"] = "프리셋 \"%s\" 적용됨 (%d포인트).",
  ["preset.err"] = "프리셋을 적용할 수 없습니다.",

  -- origin
  ["origin.classic"] = "클래식",

  -- type
  ["type.dungeon_new"] = "포에버 신규 던전",
  ["type.dungeon_classic"] = "클래식 던전",
  ["type.raid_new"] = "포에버 신규 공격대",
  ["type.raid_classic"] = "클래식 공격대",
  ["type.instance_new"] = "포에버 신규 인스턴스",
  ["type.instance_classic"] = "클래식 인스턴스",

  -- rep
  ["rep.orgrimmar"] = "오그리마",
  ["rep.thunder_bluff"] = "썬더 블러프",
  ["rep.undercity"] = "언더시티",
  ["rep.ironforge"] = "아이언포지",
  ["rep.stormwind"] = "스톰윈드",
  ["rep.darnassus"] = "다르나서스",
  ["rep.gnomeregan_exiles"] = "놈리건 피난민",
  ["rep.ratchet"] = "래칫",
  ["rep.gadgetzan"] = "가젯잔",
  ["rep.argent_dawn"] = "은빛 여명회",
  ["rep.cenarion_circle"] = "세나리온 의회",

  -- chain
  ["chain.part"] = "연계 퀘스트의 일부 (단계 기록 필요)",
  ["chain.next"] = "연계 퀘스트의 다음 단계 (단계 기록 필요)",
  ["chain.teleporter"] = "놈리건 순간이동기와 연결된 연계 퀘스트",
  ["chain.title_caps"] = "연계 퀘스트: 이전 단계",
  ["chain.start_outside"] = "연계 퀘스트는 인스턴스 밖에서 시작합니다: %s.",
  ["chain.at_zone"] = "%s 지역",
  ["chain.from_npc"] = "%s 에게서",
  ["chain.start_item"] = "연계 퀘스트는 게임에서 찾은 아이템으로 시작합니다.",
  ["chain.to_verify"] = "확인 필요",

  -- filter
  ["filter.all"] = "전체",
  ["filter.new"] = "신규",
  ["filter.raids"] = "공격대",

  -- section
  ["section.levels"] = "%d~%d레벨",
  ["section.raids"] = "공격대",

  -- unit
  ["unit.dungeon.one"] = "던전 %d개",
  ["unit.dungeon.other"] = "던전 %d개",
  ["unit.raid.one"] = "공격대 %d개",
  ["unit.raid.other"] = "공격대 %d개",
  ["unit.quest.one"] = "퀘스트 %d개",
  ["unit.quest.other"] = "퀘스트 %d개",
  ["unit.boss.one"] = "우두머리 %d명",
  ["unit.boss.other"] = "우두머리 %d명",

  -- fmt
  ["fmt.thousands_sep"] = ",",
  ["fmt.date"] = "%3$s. %2$s. %1$s.",

  -- money
  ["money.g"] = "골드",
  ["money.s"] = "실버",
  ["money.c"] = "코퍼",

  -- card
  ["card.players"] = "%s명",
  ["card.visual_soon_caps"] = "이미지 준비 중",
  ["card.faction"] = "진영: %s",
  ["card.level_recommended"] = "권장 레벨 %s",
  ["card.level_max"] = "%d레벨",
  ["card.quests_todo"] = "퀘스트: 미정",
  ["card.quests_side"] = "%s: %s",

  -- dungeons
  ["dungeons.footer"] = "%s 기준 데이터 - 인스턴스 %d개",
  ["dungeons.footer_nodate"] = "데이터 - 인스턴스 %d개",
  ["dungeons.title"] = "던전 및 공격대",
  ["dungeons.sub"] = "클래식과 신규를 포함한 13레벨부터 60레벨까지의 월드 오브 워크래프트 포에버 던전 %d개와 공격대.",
  ["search.placeholder"] = "던전, 우두머리 또는 전리품…",
  ["search.none"] = "결과 없음",

  -- detail
  ["detail.back"] = "모든 던전",
  ["detail.show_entrance"] = "입구 표시",
  ["detail.tab_quests"] = "퀘스트",
  ["detail.tab_boss"] = "우두머리",
  ["detail.tab_quests_count"] = "퀘스트 %d",
  ["detail.tab_boss_count"] = "우두머리 %d",

  -- point
  ["point.this"] = "이 위치",
  ["point.entrance"] = "입구: %s",

  -- fact
  ["fact.zone"] = "지역",
  ["fact.entry"] = "입구",
  ["fact.faction"] = "진영",
  ["fact.level_required"] = "요구 레벨",
  ["fact.group_finder"] = "파티 찾기",
  ["fact.players"] = "인원",
  ["fact.access_todo"] = "입장 조건: 미정",

  -- boss
  ["boss.rare"] = "희귀",
  ["boss.quest"] = "퀘스트",
  ["boss.with"] = "%s 와(과) 함께",
  ["boss.none"] = "이 인스턴스에 알려진 우두머리가 없습니다.",
  ["boss.select"] = "우두머리를 선택하세요.",
  ["boss.met"] = "게임에서 조우함",
  ["boss.no_pin"] = "지도 위치 없음",
  ["boss.pin_with"] = "%s (%s 와(과) 함께)",
  ["boss.caps"] = "우두머리",

  -- item
  ["item.loading"] = "아이템 %d (불러오는 중)",

  -- loot
  ["loot.caps"] = "전리품",
  ["loot.none"] = "이 우두머리의 전리품이 기록되지 않았습니다 (베타).",
  ["loot.verify_classic_caps"] = "확인 필요: 클래식 전리품",
  ["loot.verify_external_caps"] = "확인 필요: 외부 출처",
  ["loot.seen"] = "게임에서 이 우두머리에게서 %s (%s).",
  ["loot.items_seen.one"] = "아이템 %d개 확인",
  ["loot.items_seen.other"] = "아이템 %d개 확인",
  ["loot.kills_noted.one"] = "처치 %d회 기록",
  ["loot.kills_noted.other"] = "처치 %d회 기록",
  ["loot.disclaimer"] = "월드 오브 워크래프트 포에버의 블리자드 API가 많은 정보를 숨기고 있어(적어도 베타 기간 동안) 전리품 목록에 오류가 있을 수 있습니다. 앞으로 계속 업데이트됩니다. 이 목록을 최종본으로 여기지 마세요.",

  -- quest
  ["quest.meta_chain"] = "연계",
  ["quest.meta_in_log"] = "퀘스트 목록에 있음",
  ["quest.meta_unconfirmed"] = "미확인",
  ["quest.none_instance"] = "이 인스턴스에 알려진 퀘스트가 없습니다.",
  ["quest.none_faction"] = "이 진영의 퀘스트가 없습니다.",
  ["quest.select"] = "퀘스트를 선택하세요.",
  ["quest.fallback_name"] = "퀘스트 %d",
  ["quest.state_for"] = "%s: %s",
  ["quest.tag_level"] = "%s레벨",
  ["quest.tag_chain"] = "연계 퀘스트",
  ["quest.tag_unconfirmed"] = "미확인 (베타)",
  ["quest.locked_hint"] = "수행 불가: 이전 단계를 완료하지 않았습니다 (아래 연계 퀘스트 참조).",
  ["quest.objectives_caps"] = "목표",
  ["quest.giver_caps"] = "의뢰인",
  ["quest.start_caps"] = "시작",
  ["quest.turnin_caps"] = "완료",
  ["quest.rewards_caps"] = "보상",
  ["quest.rewards_choice_caps"] = "보상: 아이템 하나를 선택",
  ["quest.xp"] = "경험치 %s",
  ["quest.rewards_external"] = "게임이 아직 이 보상을 제공하지 않습니다: 외부 출처의 정보입니다. 게임에서 확인하세요.",
  ["quest.rewards_none"] = "보상이 기록되지 않았습니다.",

  -- place
  ["place.unknown"] = "알 수 없음",

  -- map
  ["map.floor_n"] = "%d층",
  ["map.level_n"] = "%d층",
  ["map.levels_caps"] = "층",

  -- pin
  ["pin.no_position"] = "아직 지도 위치 없음",
  ["pin.click_loot"] = "클릭: 전리품 보기",
  ["pin.rare_prefix"] = "희귀. %s",
  ["pin.quest_boss_prefix"] = "퀘스트 우두머리. %s",
  ["pin.variable"] = "위치 변동: 이 %d곳 중 한 곳. %s",
  ["pin.quest_item"] = "퀘스트 아이템",
  ["pin.rare_off_list"] = "희귀, 우두머리 목록에 없음",
  ["pin.to_verify"] = "확인 필요: 우두머리 목록에 없음",

  -- audit
  ["audit.done"] = "조사 완료: 퀘스트 %d/%d개를 서버에서 확인(%d개 미확인), 아이템 %d/%d개 확인(%d개 미확인), 저널의 인스턴스 %d개. /reload 를 입력해 저장하세요.",
  ["audit.running"] = "조사가 이미 진행 중입니다.",
  ["audit.started"] = "조사 진행 중: 서버에 퀘스트 %d개와 아이템 %d개를 요청합니다 (최대 3분).",
  ["audit.forbidden"] = "클라이언트가 동작을 거부했습니다: %s (수정을 위해 기록됨).",
  ["audit.loot_summary"] = "던전에서 기록됨: 우두머리 %d명 조우, 아이템 %d개 (NPC %d명). 다음 조사에서 집계됩니다.",

  -- instfaction
  ["instfaction.both"] = "호드 / 얼라이언스",

  -- availability
  ["availability.not_open"] = "아직 열리지 않음",
  ["availability.opens_dec9"] = "12월 9일 오픈",

  -- instance
  ["instance.group_change"] = "파티 규모가 10인(클래식 시대)에서 5인으로 변경되었습니다.",
})
