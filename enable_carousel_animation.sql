-- ============================================================================
-- Enable Carousel Animation (Horizontal Scrolling)
-- All cards move together from right to left continuously
-- ============================================================================

-- Update card sections to use carousel animation
UPDATE sections
SET
    animation_type = 10,        -- ANIM_CAROUSEL
    animation_duration = 8.0,   -- 8 seconds for complete scroll cycle
    animation_delay = 0,        -- Start immediately
    animation_repeat = TRUE     -- Continuous loop (always true for carousel)
WHERE type = 4  -- SEC_CARDS
  AND display = 'flex'
  AND id IN (SELECT id FROM sections WHERE type = 4 AND display = 'flex' LIMIT 3);

-- Show updated sections
SELECT
    t.template_name,
    s.section_order,
    s.animation_type,
    s.animation_duration,
    s.animation_repeat
FROM sections s
JOIN templates t ON s.template_id = t.id
WHERE s.animation_type = 10;

\echo '✅ Carousel animation enabled!'
\echo ''
\echo 'HOW IT WORKS:'
\echo '• All cards scroll together from right to left'
\echo '• When a card exits left side, it wraps to right side'
\echo '• Seamless infinite loop - no restart visible'
\echo '• 8 second cycle (adjustable via slider 1-20s)'
\echo ''
\echo 'TO TEST:'
\echo '1. Launch: ./imgui_website_designer'
\echo '2. Load a template (hotel, Stripe, Nike)'
\echo '3. Watch cards scroll continuously!'
\echo '4. Adjust speed in right panel: Animation > Scroll Speed'
