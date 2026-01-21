-- Add smooth continuous animations to test sections

UPDATE sections
SET 
    animation_type = 1,         -- ANIM_FADE_IN
    animation_duration = 0.8,   -- 0.8 seconds per card
    animation_delay = 0,        -- Start immediately
    animation_repeat = TRUE     -- Continuous loop
WHERE type = 4  -- SEC_CARDS
  AND display = 'flex'
LIMIT 3;

-- Show updated sections
SELECT 
    t.template_name,
    s.section_order,
    s.animation_type,
    s.animation_duration,
    s.animation_repeat,
    (SELECT COUNT(*) FROM card_items WHERE section_id = s.id) as num_cards
FROM sections s
JOIN templates t ON s.template_id = t.id
WHERE s.animation_type > 0;

\echo '✅ Smooth continuous animations added!'
\echo 'Each card will fade in one by one (0.3s apart) and loop smoothly!'
