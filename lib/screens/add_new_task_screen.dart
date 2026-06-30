import 'package:flutter/material.dart';
import 'package:life_garden/core/model/new_task_model.dart';
import 'package:life_garden/core/model/task_category.dart';
import 'package:life_garden/core/routes/app_routes.dart';
import 'package:life_garden/core/theme/app_colors.dart';
import 'package:life_garden/core/theme/app_spacing.dart';
import 'package:life_garden/core/widgets/add_subtasks_row.dart';
import 'package:life_garden/core/widgets/category_chip.dart';
import 'package:life_garden/core/widgets/date_picker_row.dart';
import 'package:life_garden/core/widgets/reward_card.dart';
import 'package:life_garden/core/widgets/section_label.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  late NewTaskModel _task;
  final _nameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _task = NewTaskModel(date: DateTime.now());
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    super.dispose();
  }

  void _selectCategory(TaskCategory cat) {
    setState(() {
      _task = _task.copyWith(
        category: _task.category?.id == cat.id ? null : cat,
      );
    });
  }

  void _onCreateTask() {
    if (_task.name.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please enter a task name'),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
        ),
      );
      _nameFocusNode.requestFocus();
      return;
    }
    Navigator.of(context).pop(_task);
  }

  @override
  Widget build(BuildContext context) {
    final padding = AppSpacing.screenPadding(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: GestureDetector(
    
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            // ── Scrollable content ────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: padding.copyWith(
                  top: AppSpacing.sm,
                  bottom: AppSpacing.xl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.sm),

                    // ── Task Name ─────────────────
                    const SectionLabel('TASK NAME'),
                    const SizedBox(height: AppSpacing.sm + 2),
                    _TaskNameField(
                      focusNode: _nameFocusNode,
                      onChanged: (v) =>
                          setState(() => _task = _task.copyWith(name: v)),
                    ),

                    const SizedBox(height: AppSpacing.lg + 4),
                    const _Divider(),
                    const SizedBox(height: AppSpacing.lg),

                    // ── Category ──────────────────
                    _CategorySection(
                      selected: _task.category,
                      onSelect: _selectCategory,
                    ),

                    const SizedBox(height: AppSpacing.lg + 4),
                    const _Divider(),
                    const SizedBox(height: AppSpacing.lg),

                    // ── When ──────────────────────
                    const SectionLabel('When?'),
                    const SizedBox(height: AppSpacing.sm + 2),
                    DatePickerRow(
                      selectedDate: _task.date,
                      onDateChanged: (d) =>
                          setState(() => _task = _task.copyWith(date: d)),
                    ),

                    const SizedBox(height: AppSpacing.lg + 4),
                    const _Divider(),
                    const SizedBox(height: AppSpacing.lg),

                    // ── Harvest Reward ────────────
                    const SectionLabel('Harvest Reward'),
                    const SizedBox(height: AppSpacing.sm + 2),
                    HarvestRewardCard(estimatedCoins: _task.estimatedCoins),

                    const SizedBox(height: AppSpacing.lg + 4),
                    const _Divider(),
                    const SizedBox(height: AppSpacing.lg),

                    // ── Add subtasks / notes ──────
                    AddSubtasksRow(onTap: () {}),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),

            // ── Create Task button (pinned) ───────
            _CreateTaskButton(onTap: _onCreateTask),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.textPrimary,
          size: 18,
        ),
        onPressed: () {
          // canPop true hai toh peeche jao (SanctuaryScreen)
          //  canPop false hai toh explicitly sanctuary pe jao
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).pushReplacementNamed(AppRoutes.sanctuary);
          }
        },
      ),

      title: const Text(
        'Add New Task',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      centerTitle: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Divider(
          height: 1,
          thickness: 1,
          color: AppColors.divider,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.more_vert,
            color: AppColors.textMuted,
            size: 20,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────
// Task Name Field
// ─────────────────────────────────────────
class _TaskNameField extends StatelessWidget {
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const _TaskNameField({
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      onChanged: onChanged,
      maxLines: 3,
      minLines: 2,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.35,
      ),
      decoration: const InputDecoration(
        hintText: 'What would you like to\nachieve?',
        hintStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: AppColors.taskUnchecked,
          height: 1.35,
        ),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}

// ─────────────────────────────────────────
// Category Section
// ─────────────────────────────────────────
class _CategorySection extends StatelessWidget {
  final TaskCategory? selected;
  final ValueChanged<TaskCategory> onSelect;

  const _CategorySection({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionLabel('Category'),
            //  FIX: AbsorbPointer nahi — GestureDetector theek se kaam kare
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: const Text(
                'New Category',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm + 2),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: TaskCategory.defaults.map((cat) {
            return CategoryChip(
              category: cat,
              isSelected: selected?.id == cat.id,
              onTap: () => onSelect(cat),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────
// Thin Divider
// ─────────────────────────────────────────
class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Divider(height: 1, thickness: 1, color: AppColors.divider);
  }
}

// ─────────────────────────────────────────
// Create Task Button (pinned bottom)
// ─────────────────────────────────────────
class _CreateTaskButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CreateTaskButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Container(
      color: AppColors.background,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        bottom + AppSpacing.md,
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.background,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
            ),
          ),
          child: const Text(
            'Create Task',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
