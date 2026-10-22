-- (c) Poulpix, Azeroth Forever. All rights reserved. Text and data mining and AI training prohibited (noai, noimageai, EU Directive 2019/790 art. 4). See LICENSE.md.
-- Japanese. Complete: same keys as frFR and enUS. Tone: short, noun or dictionary form, like the WoW UI.
-- Tokens (%s, %d, |cffRRGGBB, |r) are kept as in frFR. Japanese has no capitals: the _caps keys are plain text.
-- The Legacy tree keeps its original key prefix, only the displayed word is the katakana for Legacy. One plural form only (.one and .other are identical).
local ADDON_NAME, AF = ...

AF:RegisterLocale("jaJP", {
  -- core
  ["core.loaded"] = "をロードしました%s。|cffffd100/af|r と入力するかミニマップのボタンをクリックすると開きます。",
  ["core.ui_missing"] = "インターフェースが読み込まれていません。",

  -- path
  ["path.err.empty"] = "ルートが空か、途中で切れています。",
  ["path.err.version"] = "不明なルートのバージョンです。",
  ["path.err.header"] = "ルートのヘッダーが無効です。",
  ["path.err.too_long"] = "ルートが長すぎます(%dポイント超)。",
  ["path.err.char"] = "ルートに無効な文字があります。",
  ["path.err.unknown_talent"] = "このルートに不明なタレントがあります。",
  ["path.err.maxed"] = "%sはすでに最大ランク(%d)です。",
  ["path.err.cap"] = "%dポイントの上限に達しました。",
  ["path.err.other_talent"] = "別のタレント",
  ["path.err.prereq"] = "%sには%s(ランク%d)が必要です。",
  ["path.err.tier"] = "%sには%dポイントが必要です(%sツリー内。ルートのこの時点では%dポイント)。",
  ["path.err.cannot_remove"] = "%sを外せません: %s",

  -- talents
  ["talents.err.class_unknown"] = "不明なクラスです。",
  ["talents.err.talent_unknown"] = "不明なタレントです。",
  ["talents.count"] = "タレント%d個",
  ["talents.head_sub"] = "%s · %s、新規%d、変更%d",
  ["talents.client_data"] = "クライアントのデータ %s",

  -- apply
  ["apply.err.unreadable"] = "ゲーム内のタレントを読み取れません: /af diag と入力してください。",
  ["apply.err.not_found"] = "クライアントに%sが見つかりません。",
  ["apply.err.not_learnable"] = "%sはまだ習得できません(前提条件またはツリーのポイント)。",
  ["apply.info.nothing_to_apply_learned"] = "適用するものがありません: ビルドはすでにゲーム内で習得済みです。",
  ["apply.err.cannot_unlearn"] = "ゲームでは習得済みのポイントを1つだけ取り消すことはできません",
  ["apply.err.combat"] = "戦闘中は実行できません。",
  ["apply.err.locked"] = "現在タレントを変更できません。",
  ["apply.err.no_points"] = "このキャラクターには使えるタレントポイントがありません。",
  ["apply.err.no_more_points"] = "ビルドの残りに使えるポイントがありません。",
  ["apply.err.refused"] = "ゲームが%sを拒否しました。",
  ["apply.err.nothing"] = "適用するものがありません。",
  ["apply.err.not_validated"] = "ゲームがタレントを確認しませんでした。",
  ["apply.err.none_learned"] = "ゲーム内で習得したビルドのポイントがありません。",
  ["apply.err.refused_remove"] = "ゲームが%sの取り消しを拒否しました。",
  ["apply.ok.removed"] = "ゲーム内で取り消しました: %s。",
  ["apply.err.timeout"] = "ゲームが指定のタレントを習得しませんでした。",
  ["apply.warn.learned.one"] = "%dポイント習得しました。%s",
  ["apply.warn.learned.other"] = "%dポイント習得しました。%s",
  ["apply.ok.build_applied"] = "ビルドをゲーム内に適用しました: %dポイント習得。",
  ["apply.ok.learned"] = "ゲーム内で習得しました: %s。",

  -- share
  ["share.err.empty_any"] = "AF1-(クラス)またはAF1H-(レガシー)で始まるコードを貼り付けてください。",
  ["share.err.not_af_any"] = "Azeroth Foreverのコードではありません。AF1-またはAF1H-で始まる必要があります。",
  ["share.err.incomplete"] = "コードが不完全です。最後の2文字までそのままコピーしてください。",
  ["share.err.corrupt"] = "コードが壊れています(チェックサムが不正)。そのままコピーしてください。",
  ["share.err.kind"] = "不明なコードの種類です。",
  ["share.err.class_in_code"] = "このコードに不明なクラスがあります。",
  ["share.err.empty_class"] = "AF1-で始まるコードを貼り付けてください。",
  ["share.err.is_heritage"] = "これはレガシーのコードです。レガシータブで読み込んでください。",
  ["share.err.not_af_class"] = "Azeroth Foreverのコードではありません。AF1-で始まる必要があります。",
  ["share.err.class_or_catalog"] = "このコードのクラスが不明です(またはタレントカタログが異なります。アドオンを更新してください)。",
  ["share.err.catalog_changed"] = "タレントカタログが変更されました。アドオンを更新してください(%s)",
  ["share.err.impossible_order"] = "このコードは不可能な順序を示しています(ステップ%d): %s",
  ["share.export_error"] = "エクスポートできません: %s",
  ["share.copy_link"] = "リンクをコピー",
  ["share.link_help_build"] = "このページへのリンク(ビルド+ポイントの順序)",
  ["share.copy_code"] = "アドオンコードをコピー",
  ["share.code_help_class"] = "アドオンまたはサイトに貼り付けるAF1-コード",
  ["share.code_title"] = "アドオンコード",
  ["share.paste"] = "コードを貼り付け",
  ["share.paste_menu_help"] = "AF1-コード(クラス)またはAF1H-コード(レガシー)",
  ["share.paste_popup_help"] = "AF1-(クラス)またはAF1H-(レガシー)のコードを入力して、インポートを押してください。",
  ["share.public_help"] = "Ctrl+Cでコピーし、ブラウザでリンクを開いてください。",
  ["share.public_title"] = "公開ビルド %s",

  -- heritage
  ["heritage.err.is_class"] = "これはクラスのコード(AF1-)で、レガシーのコードではありません。",
  ["heritage.err.version"] = "不明なレガシーコードのバージョンです。サイトを更新してください。",
  ["heritage.err.unreadable"] = "レガシーコードを読み取れません(%dランクのはずが%dランク)。",
  ["heritage.err.rank_max"] = "%sはランク%dを超えられません。",
  ["heritage.err.too_many"] = "このコードはレガシーポイントを%d超消費しています。",
  ["heritage.err.tiers"] = "このコードはツリーのポイント段階を満たしていません。",
  ["heritage.err.node_unknown"] = "不明なノードです。",
  ["heritage.err.cap"] = "レガシーの上限%dポイントに達しました。",
  ["heritage.err.tier_locked"] = "%sの段階に達していません。",
  ["heritage.err.preset_invalid"] = "無効なプリセットです。",
  ["heritage.err.preset_unknown"] = "不明なプリセットです。",
  ["heritage.title"] = "レガシーツリー",
  ["heritage.sub"] = "専門技能 · 冒険 · 創意 · %s",
  ["heritage.total_points"] = "%dポイント",
  ["heritage.stat.spent_caps"] = "消費ポイント",
  ["heritage.stat.left_caps"] = "残りポイント",
  ["heritage.reset_done"] = "レガシーをリセットしました。",
  ["heritage.view_at"] = "消費ポイント%sでのレガシービルドを表示",
  ["heritage.unknown_skill"] = "不明なスキル",
  ["heritage.unknown_skill_hint"] = "今後のアップデートで追加されます。",
  ["heritage.tip.rank_meta"] = "ランク %d/%d · %s",
  ["heritage.tip.passive"] = "パッシブ",
  ["heritage.tip.at_points"] = "%dポイント消費時: ランク %d/%d",
  ["heritage.tip.requires"] = "レガシーポイント%dを%sに消費する必要があります。",
  ["heritage.imported"] = "レガシーをインポートしました(%dポイント)。",
  ["heritage.link_help"] = "このページへのリンク(?hbuild=)",
  ["heritage.code_help"] = "アドオンまたはサイトに貼り付けるAF1H-コード",
  ["heritage.talented_note"] = "クラスのタレントはレベル9から始まります。",
  ["heritage.tree.professions"] = "専門技能",
  ["heritage.col.professions.sub"] = "製造、採集、ゴールド。",
  ["heritage.node.travail-acharne.name"] = "ひたむきな努力",
  ["heritage.node.travail-acharne.desc"] = "メイン専門技能、サブ専門技能、クラス専門技能を使ったときにスキルポイントを得る確率が4%増加する。",
  ["heritage.node.marchandage.name"] = "値切り交渉",
  ["heritage.node.marchandage.desc"] = "すべての商人から購入するアイテムのゴールド価格が5%減少する。",
  ["heritage.node.chef-etoile.name"] = "スターシェフ",
  ["heritage.node.chef-etoile.desc"] = "料理のレシピで10%の確率で追加の成果物が作れる。",
  ["heritage.node.etude-assidue.name"] = "勤勉な研究",
  ["heritage.node.etude-assidue.desc"] = "現在のメイン専門技能とサブ専門技能のうち最も低いスキルが1ポイント上昇する。メイン専門技能2つとサブ専門技能3つがすべて300に達している場合は、エレメンタルエッセンスをランダムに2~4個入手する。",
  ["heritage.node.etude-assidue.meta"] = "詠唱時間25秒、クールダウン23時間",
  ["heritage.node.recolte-abondante.name"] = "豊かな収穫",
  ["heritage.node.recolte-abondante.desc"] = "採掘、薬草採集、剥ぎ取りで入手する上質の素材が20%増える。",
  ["heritage.node.prime-de-rendement.name"] = "収益ボーナス",
  ["heritage.node.prime-de-rendement.desc"] = "アゼロス商業公社またはデュロタル物流に木箱を納品するとき、5%の確率で商人の好意を100%多く獲得する。",
  ["heritage.node.maitre-appateur.name"] = "餌の達人",
  ["heritage.node.maitre-appateur.desc"] = "餌を使って釣りをすると、25%の確率でもう1匹釣れる。",
  ["heritage.tree.adventure"] = "冒険",
  ["heritage.col.adventure.sub"] = "進行、探索、便利機能。",
  ["heritage.node.haute-vigilance.name"] = "高度な警戒",
  ["heritage.node.haute-vigilance.desc"] = "レベルが1上がったかのように、近くの隠れた対象を見破る能力が上昇する。戦場では無効。",
  ["heritage.node.bien-repose.name"] = "十分な休息",
  ["heritage.node.bien-repose.desc"] = "休息経験値の蓄積速度が4%上昇し、上限が4%増加する。",
  ["heritage.node.talentueux.name"] = "才能豊か",
  ["heritage.node.talentueux.desc"] = "レベル10ではなくレベル9から、レベルが上がるごとにタレントポイントを1つ獲得する。合計51タレントポイントを超えることはない。",
  ["heritage.node.frisson-aventure.name"] = "冒険のスリル",
  ["heritage.node.frisson-aventure.desc"] = "取るに足らない敵以外にとどめを刺すたびに、10秒かけて最大体力と最大マナの1%を回復する。ダンジョン、レイド、戦場では無効。",
  ["heritage.node.guide-de-terrain.name"] = "野外ガイド",
  ["heritage.node.guide-de-terrain.desc"] = "キャンプの設備を追加するクールダウンが8%短縮される。",
  ["heritage.node.grand-voyageur.name"] = "熟練の旅人",
  ["heritage.node.grand-voyageur.desc"] = "すべての飛行経路が50%割引になり、飛行マウントの飛行速度が20%上昇する。",
  ["heritage.node.medecine-de-terrain.name"] = "野外医療",
  ["heritage.node.medecine-de-terrain.desc"] = "包帯を使ったときの「包帯の効果が切れたばかり」の持続時間が5秒短縮される。ダンジョン、レイド、戦場では無効。",
  ["heritage.tree.ingenuity"] = "創意",
  ["heritage.col.ingenuity.sub"] = "維持、評判、名誉。",
  ["heritage.node.pour-un-plus-grand-honneur.name"] = "より大きな名誉のために",
  ["heritage.node.pour-un-plus-grand-honneur.desc"] = "獲得する名誉ポイントが2%増加する。",
  ["heritage.node.gourmet.name"] = "グルメ",
  ["heritage.node.gourmet.desc"] = "食べ物による有益な効果の持続時間が33%延長される。",
  ["heritage.node.permanence.name"] = "持続",
  ["heritage.node.permanence.desc"] = "クラスのアビリティがパーティやレイドに与える長時間のステータス強化の持続時間が50%延長される。キャンプで休息して得られる効果も同様。",
  ["heritage.node.les-vifs-et-les-morts.name"] = "生者と死者",
  ["heritage.node.les-vifs-et-les-morts.desc"] = "死亡中の移動速度が5%上昇し、蘇生後1分間、または戦闘に入るまで、有益な呪文とアビリティの消費リソースがなくなる。",
  ["heritage.node.economie-de-reactifs.name"] = "触媒の節約",
  ["heritage.node.economie-de-reactifs.desc"] = "クラスのアビリティで商人から購入できる触媒が不要になり、ランク1のキャンプ設備の製作にも触媒が不要になる。",
  ["heritage.node.renforcement.name"] = "補強",
  ["heritage.node.renforcement.desc"] = "死亡時の耐久度の減少が8%少なくなる。",
  ["heritage.node.diplomate.name"] = "外交官",
  ["heritage.node.diplomate.desc"] = "評判の獲得量が2%増加する。",

  -- tab
  ["tab.talents"] = "タレント",
  ["tab.heritage"] = "レガシー",
  ["tab.dungeons"] = "ダンジョン&レイド",

  -- faction
  ["faction.alliance_caps"] = "アライアンス",
  ["faction.horde_caps"] = "ホード",
  ["faction.alliance"] = "アライアンス",
  ["faction.horde"] = "ホード",
  ["faction.both"] = "中立",

  -- ui
  ["ui.err_section"] = "インターフェースエラー(%s): %s",
  ["ui.err"] = "インターフェースエラー: %s",
  ["ui.tagline"] = "WOW FOREVER用ツール",
  ["ui.close"] = "閉じる(Esc)",
  ["ui.site_tip"] = "コピー用のサイトリンク",
  ["ui.site_title"] = "Azeroth Foreverのウェブサイト",
  ["ui.site_hint"] = "Ctrl+Cでリンクをコピーし、ブラウザに貼り付けてください。",

  -- cmd
  ["cmd.scale"] = "ウィンドウの拡大率: %s",
  ["cmd.diag_saved"] = "/reload後に診断結果をSavedVariables\\AzerothForever.luaに保存しました。",
  ["cmd.debug"] = "デバッグモード: %s",
  ["cmd.help"] = "コマンド: /af, /af talents, /af legacy, /af dungeons, /af scale 0.8, /af diag, /af survey, /af loot, /af minimap, /af locale, /af debug",
  ["cmd.locale_current"] = "使用中の言語: %s(クライアント: %s)。変更するには: /af locale frFR、/af locale auto。",
  ["cmd.locale_set"] = "言語: %s。/reloadで反映されます。",
  ["cmd.locale_auto"] = "言語は自動(%s)。/reloadで反映されます。",
  ["cmd.locale_bad"] = "不明な言語: %s。指定できる値: %s。",
  -- language picker (header)
  ["lang.button_tip"] = "アドオンの言語",
  ["lang.auto"] = "ゲームの言語",
  ["lang.auto_help"] = "現在: %s",
  ["lang.need_client"] = "この言語のゲームクライアントが必要（フォント）",
  ["lang.reload_confirm"] = "選択した言語: %s。インターフェースの再読み込み後に適用されます。今すぐ再読み込みしますか？",
  ["lang.reload"] = "再読み込み",
  ["lang.frFR"] = "フランス語",
  ["lang.enUS"] = "英語",
  ["lang.deDE"] = "ドイツ語",
  ["lang.esES"] = "スペイン語（スペイン）",
  ["lang.esMX"] = "スペイン語（メキシコ）",
  ["lang.itIT"] = "イタリア語",
  ["lang.koKR"] = "韓国語",
  ["lang.jaJP"] = "日本語",

  -- state
  ["state.on"] = "有効",
  ["state.off"] = "無効",
  ["state.done"] = "完了",
  ["state.log"] = "進行中",
  ["state.avail"] = "受注可能",
  ["state.locked"] = "受注不可",
  ["state.done_caps"] = "完了",
  ["state.log_caps"] = "進行中",
  ["state.avail_caps"] = "受注可能",
  ["state.locked_caps"] = "受注不可",

  -- minimap
  ["minimap.tip.left"] = "左クリック: 開く / 閉じる",
  ["minimap.tip.right"] = "右クリック: ダンジョン&レイド",
  ["minimap.tip.drag"] = "ドラッグ: ボタンを移動",
  ["minimap.tip.cmd"] = "/af minimap: 非表示 / 表示",
  ["minimap.hidden"] = "ミニマップのボタンを非表示にしました。再表示するには /af minimap と入力してください。",
  ["minimap.shown"] = "ミニマップのボタンを表示しました。",

  -- common
  ["common.close"] = "閉じる",
  ["common.import"] = "インポート",
  ["common.cancel"] = "キャンセル",
  ["common.ok"] = "OK",
  ["common.confirm"] = "確認",
  ["common.lvl"] = "Lv%s",
  ["common.lvl_lower"] = "Lv%s",
  ["common.level_n"] = "レベル%s",
  ["common.required_n"] = "必要: %s",
  ["common.show"] = "表示",

  -- popup
  ["popup.copy_help"] = "Ctrl+Cでコピー、Escで閉じる。",
  ["popup.code_unreadable"] = "コードを読み取れません。",

  -- status
  ["status.new"] = "新規",
  ["status.changed"] = "変更",
  ["status.unchanged"] = "同一を確認済み",

  -- mode
  ["mode.final"] = "レベル60ビルド",
  ["mode.path"] = "レベル別ビルド",
  ["mode.final_hint"] = "レベル60ビルド: 最終的なポイントを配置すると、レベル上げの順序は自動で決まります。",
  ["mode.path_hint"] = "レベル別ビルド: クリックするごとに、レベルアップ時に取る次のポイントになります。",

  -- badge
  ["badge.changed_from_classic"] = "クラシックから変更",
  ["badge.new_in_forever"] = "Foreverで新規",

  -- stat
  ["stat.spent_caps"] = "消費ポイント",
  ["stat.left_caps"] = "残りポイント",
  ["stat.level_required_caps"] = "必要レベル",
  ["stat.available_caps"] = "使用可能",
  ["stat.spent_short_caps"] = "消費",

  -- btn
  ["btn.public_builds"] = "公開ビルド",
  ["btn.public_builds_class"] = "公開ビルド %s",
  ["btn.share"] = "共有",
  ["btn.save"] = "保存",
  ["btn.reset"] = "リセット",
  ["btn.view_order"] = "ポイントの順序を表示",
  ["btn.automatic"] = "自動",
  ["btn.automatic_tip"] = "レベルアップするたびに、ビルドの次のポイントをゲーム内に適用します",
  ["btn.sync"] = "同期",
  ["btn.sync_tip"] = "ビルドをこのキャラクターが習得したタレントに置き換えます",
  ["btn.undo"] = "元に戻す",
  ["btn.undo_tip"] = "ゲーム内で最後に習得したポイントを取り消します",
  ["btn.apply_all"] = "全ポイントを適用",
  ["btn.apply_all_tip"] = "ビルドのすべてのポイントをゲーム内に適用します",
  ["btn.apply_next"] = "次のポイントを適用",
  ["btn.apply_next_tip"] = "ビルドの次のポイントをゲーム内に適用します",
  ["btn.apply"] = "適用",

  -- toggle
  ["toggle.classic_version"] = "クラシック版",

  -- planner
  ["planner.view_at_level"] = "レベル%sでのビルドを表示",

  -- tree
  ["tree.reset_tip"] = "このツリーをリセット",
  ["tree.pts"] = "%dpt",
  ["tree.pts_at"] = "%d/%dpt",
  ["tree.warrior.arms"] = "武器",
  ["tree.warrior.fury"] = "怒り",
  ["tree.warrior.protection"] = "防御",
  ["tree.paladin.holy"] = "神聖",
  ["tree.paladin.protection"] = "防御",
  ["tree.paladin.retribution"] = "報復",
  ["tree.hunter.beast_mastery"] = "ビーストマスタリー",
  ["tree.hunter.marksmanship"] = "射撃",
  ["tree.hunter.survival"] = "サバイバル",
  ["tree.rogue.assassination"] = "暗殺",
  ["tree.rogue.combat"] = "戦闘",
  ["tree.rogue.subtlety"] = "諜報",
  ["tree.priest.discipline"] = "規律",
  ["tree.priest.holy"] = "神聖",
  ["tree.priest.shadow"] = "闇",
  ["tree.shaman.elemental"] = "エレメンタル",
  ["tree.shaman.enhancement"] = "強化",
  ["tree.shaman.restoration"] = "回復",
  ["tree.mage.arcane"] = "秘術",
  ["tree.mage.fire"] = "火炎",
  ["tree.mage.frost"] = "氷結",
  ["tree.warlock.affliction"] = "苦痛",
  ["tree.warlock.demonology"] = "悪魔",
  ["tree.warlock.destruction"] = "破壊",
  ["tree.druid.balance"] = "バランス",
  ["tree.druid.feral"] = "野生",
  ["tree.druid.restoration"] = "回復",

  -- order
  ["order.title"] = "ポイントの順序",
  ["order.empty"] = "ポイントが未配置です。タレントをクリックして開始してください。",

  -- footer
  ["footer.in_game_caps"] = "ゲーム内",

  -- toast
  ["toast.build_cleared"] = "%sのビルドを消去しました。",
  ["toast.this_class"] = "このクラス",
  ["toast.other_class"] = "別のクラスを表示中です。ゲーム内で操作するには自分のクラスに戻してください。",
  ["toast.synced.one"] = "ビルドを同期しました: ゲーム内で%dポイント習得。",
  ["toast.synced.other"] = "ビルドを同期しました: ゲーム内で%dポイント習得。",
  ["toast.build_imported"] = "ビルドをインポートしました: %s。",
  ["toast.point_tomtom"] = "TomTomのウェイポイントを設定しました: %s。",
  ["toast.point_map"] = "マップにピンを設定しました: %s。",
  ["toast.point_unknown"] = "%sの場所が不明です。",

  -- confirm
  ["confirm.apply_all"] = "ビルドのすべてのポイントを今すぐゲーム内に適用しますか?",

  -- save
  ["save.title"] = "ビルドを保存",
  ["save.list_caps"] = "このアカウントに保存したビルド",
  ["save.empty"] = "このクラスの保存済みビルドはありません。",
  ["save.err.name"] = "ビルドに名前を付けてください。",
  ["save.err.empty"] = "ビルドが空です。保存するものがありません。",
  ["save.ok"] = "ビルド「%s」を保存しました。",
  ["save.btn_delete"] = "削除",
  ["save.btn_load"] = "読み込み",
  ["save.row_meta"] = "%dポイント · %s",
  ["save.err.unreadable"] = "現在のデータではこのビルドを読み取れません: %s",
  ["save.loaded"] = "ビルド「%s」を読み込みました。",

  -- tip
  ["tip.rank"] = "ランク %d/%d",
  ["tip.next_rank_caps"] = "次のランク",
  ["tip.classic_caps"] = "クラシック",
  ["tip.at_level"] = "レベル%d時: ランク %d/%d",
  ["tip.next_rank_classic"] = "次のランク(クラシック): %s",
  ["tip.requires_tree_points"] = "このツリーに%dポイント必要。",
  ["tip.requires_rank"] = "%s(ランク%d)",
  ["tip.requires_list"] = "必要: %s",
  ["tip.learned_in_game"] = "ゲーム内で習得: %d/%d",
  ["tip.click_learn"] = "クリック: 習得 · 右クリック: 取り消し",

  -- preset
  ["preset.leveling"] = "冒険",
  ["preset.metiers"] = "専門技能",
  ["preset.qdv60"] = "創意",
  ["preset.applied"] = "プリセット「%s」を適用しました(%dポイント)。",
  ["preset.err"] = "プリセットを適用できません。",

  -- origin
  ["origin.classic"] = "クラシック",

  -- type
  ["type.dungeon_new"] = "Foreverの新ダンジョン",
  ["type.dungeon_classic"] = "クラシックのダンジョン",
  ["type.raid_new"] = "Foreverの新レイド",
  ["type.raid_classic"] = "クラシックのレイド",
  ["type.instance_new"] = "Foreverの新インスタンス",
  ["type.instance_classic"] = "クラシックのインスタンス",

  -- rep
  ["rep.orgrimmar"] = "オグリマー",
  ["rep.thunder_bluff"] = "サンダー・ブラフ",
  ["rep.undercity"] = "アンダーシティ",
  ["rep.ironforge"] = "アイアンフォージ",
  ["rep.stormwind"] = "ストームウィンド",
  ["rep.darnassus"] = "ダーナサス",
  ["rep.gnomeregan_exiles"] = "ノームリガン亡命者",
  ["rep.ratchet"] = "ラチェット",
  ["rep.gadgetzan"] = "ガジェットザン",
  ["rep.argent_dawn"] = "アージェントドーン",
  ["rep.cenarion_circle"] = "セナリオン・サークル",

  -- chain
  ["chain.part"] = "連続クエストの一部(記録する手順)",
  ["chain.next"] = "連続クエストの次(記録する手順)",
  ["chain.teleporter"] = "ノームリガンのテレポーターに関連する連続クエスト",
  ["chain.title_caps"] = "連続クエスト: 前の手順",
  ["chain.start_outside"] = "連続クエストはインスタンスの外から始まります: %s。",
  ["chain.at_zone"] = "%sで",
  ["chain.from_npc"] = "%sから",
  ["chain.start_item"] = "連続クエストはゲーム内で見つけたアイテムから始まります。",
  ["chain.to_verify"] = "要確認",

  -- filter
  ["filter.all"] = "すべて",
  ["filter.new"] = "新規",
  ["filter.raids"] = "レイド",

  -- section
  ["section.levels"] = "レベル%d~%d",
  ["section.raids"] = "レイド",

  -- unit
  ["unit.dungeon.one"] = "ダンジョン%d件",
  ["unit.dungeon.other"] = "ダンジョン%d件",
  ["unit.raid.one"] = "レイド%d件",
  ["unit.raid.other"] = "レイド%d件",
  ["unit.quest.one"] = "クエスト%d件",
  ["unit.quest.other"] = "クエスト%d件",
  ["unit.boss.one"] = "ボス%d体",
  ["unit.boss.other"] = "ボス%d体",

  -- fmt
  ["fmt.thousands_sep"] = ",",
  ["fmt.date"] = "%3$s/%2$s/%1$s",

  -- money
  ["money.g"] = "G",
  ["money.s"] = "S",
  ["money.c"] = "C",

  -- card
  ["card.players"] = "%s人",
  ["card.visual_soon_caps"] = "イラスト準備中",
  ["card.faction"] = "陣営: %s",
  ["card.level_recommended"] = "推奨Lv%s",
  ["card.level_max"] = "レベル%d",
  ["card.quests_todo"] = "クエスト: 未定",
  ["card.quests_side"] = "%s(%s用)",

  -- dungeons
  ["dungeons.footer"] = "%s時点のデータ - %dインスタンス",
  ["dungeons.footer_nodate"] = "データ - %dインスタンス",
  ["dungeons.title"] = "ダンジョン&レイド",
  ["dungeons.sub"] = "レベル13から60までの、クラシックと新規を合わせたWorld of Warcraft Foreverの%dダンジョンと、レイド。",
  ["search.placeholder"] = "ダンジョン、ボス、戦利品…",
  ["search.none"] = "結果なし",

  -- detail
  ["detail.back"] = "すべてのダンジョン",
  ["detail.show_entrance"] = "入口を表示",
  ["detail.tab_quests"] = "クエスト",
  ["detail.tab_boss"] = "ボス",
  ["detail.tab_quests_count"] = "クエスト %d",
  ["detail.tab_boss_count"] = "ボス %d",

  -- point
  ["point.this"] = "この場所",
  ["point.entrance"] = "入口: %s",

  -- fact
  ["fact.zone"] = "地域",
  ["fact.entry"] = "入口",
  ["fact.faction"] = "陣営",
  ["fact.level_required"] = "必要レベル",
  ["fact.group_finder"] = "グループ募集",
  ["fact.players"] = "人数",
  ["fact.access_todo"] = "入場方法: 未定",

  -- boss
  ["boss.rare"] = "レア",
  ["boss.quest"] = "クエスト",
  ["boss.with"] = "%sと同時",
  ["boss.none"] = "このインスタンスのボスは不明です。",
  ["boss.select"] = "ボスを選択してください。",
  ["boss.met"] = "ゲーム内で遭遇済み",
  ["boss.no_pin"] = "マップ上の位置なし",
  ["boss.pin_with"] = "%s(%sと同時)",
  ["boss.caps"] = "ボス",

  -- item
  ["item.loading"] = "アイテム %d(読み込み中)",

  -- loot
  ["loot.caps"] = "戦利品",
  ["loot.none"] = "このボスの戦利品は未記録です(ベータ)。",
  ["loot.verify_classic_caps"] = "要確認: クラシックの戦利品",
  ["loot.verify_external_caps"] = "要確認: 外部の情報源",
  ["loot.seen"] = "このボスでゲーム内に確認: %s(%s)。",
  ["loot.items_seen.one"] = "確認したアイテム%d個",
  ["loot.items_seen.other"] = "確認したアイテム%d個",
  ["loot.kills_noted.one"] = "記録した討伐%d回",
  ["loot.kills_noted.other"] = "記録した討伐%d回",
  ["loot.disclaimer"] = "World of Warcraft Foreverの基盤となるBlizzard APIは、少なくともベータ期間中は多くの情報を隠すため、戦利品には誤りが含まれる可能性があります。随時更新していきます。このリストを最終版として扱わないでください。",

  -- quest
  ["quest.meta_chain"] = "連続",
  ["quest.meta_in_log"] = "ログ内",
  ["quest.meta_unconfirmed"] = "未確認",
  ["quest.none_instance"] = "このインスタンスのクエストは不明です。",
  ["quest.none_faction"] = "この陣営のクエストはありません。",
  ["quest.select"] = "クエストを選択してください。",
  ["quest.fallback_name"] = "クエスト %d",
  ["quest.state_for"] = "%s(%s用)",
  ["quest.tag_level"] = "レベル%s",
  ["quest.tag_chain"] = "連続クエスト",
  ["quest.tag_unconfirmed"] = "未確認(ベータ)",
  ["quest.locked_hint"] = "受注不可: 前の手順が完了していません(下の連続クエストを参照)。",
  ["quest.objectives_caps"] = "目的",
  ["quest.giver_caps"] = "依頼主",
  ["quest.start_caps"] = "開始",
  ["quest.turnin_caps"] = "報告",
  ["quest.rewards_caps"] = "報酬",
  ["quest.rewards_choice_caps"] = "報酬: アイテムを1つ選択",
  ["quest.xp"] = "経験値%s",
  ["quest.rewards_external"] = "ゲームはまだこれらの報酬を提供していません。外部の情報源によるものです。ゲーム内で確認してください。",
  ["quest.rewards_none"] = "報酬は未記録です。",

  -- place
  ["place.unknown"] = "不明",

  -- map
  ["map.floor_n"] = "%d階",
  ["map.level_n"] = "レベル%d",
  ["map.levels_caps"] = "階層",

  -- pin
  ["pin.no_position"] = "マップ上の位置はまだありません",
  ["pin.click_loot"] = "クリック: 戦利品を表示",
  ["pin.rare_prefix"] = "レア。%s",
  ["pin.quest_boss_prefix"] = "クエストボス。%s",
  ["pin.variable"] = "位置は変動: これら%d地点のいずれか。%s",
  ["pin.quest_item"] = "クエストアイテム",
  ["pin.rare_off_list"] = "レア、ボス一覧には未掲載",
  ["pin.to_verify"] = "要確認: ボス一覧にありません",

  -- audit
  ["audit.done"] = "調査完了: サーバーが把握しているクエスト%d/%d(不明%d)、アイテム%d/%d(不明%d)、ジャーナル内のインスタンス%d。/reloadで保存します。",
  ["audit.running"] = "調査はすでに実行中です。",
  ["audit.started"] = "調査を実行中: サーバーにクエスト%d件とアイテム%d個を要求します(最大3分)。",
  ["audit.forbidden"] = "クライアントが操作を拒否しました: %s(修正のため記録)。",
  ["audit.loot_summary"] = "ダンジョンで記録: 遭遇したボス%d体、アイテム%d個(NPC%d体由来)。次回の調査で集計されます。",

  -- instfaction
  ["instfaction.both"] = "ホード / アライアンス",

  -- availability
  ["availability.not_open"] = "まだ開放されていません",
  ["availability.opens_dec9"] = "12月9日開放",

  -- instance
  ["instance.group_change"] = "パーティ人数が10人(クラシック・エラ)から5人に変更されました。",
})
