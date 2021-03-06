module RecruiterLint
  module Rules
    module Sexism
      class GenderMention < Rule
        name "Gender Mention"
        desc "Mentioning gender in a recruiting email not only limits the number of people likely to " +
              "be interested, but can also have legal implications – it is often discriminatory. " +
              "Check your use of gender-specific terms."

        def run(spec, result)
          gender_words = [
            /boys?/, /bros?/, /chicks?/, /dads?/, /dudes?/,
            /fathers?/, /females?/, /gentlem[ae]n/, /girls?/,
            /grandfathers?/, /grandmas?/, /grandmothers?/, /grandpas?/,
            /grann(?:y|ies)/, /guys?/, /husbands?/, /lad(?:y|ies)/, /m[ae]n/,
            /m[ou]ms?/, /males?/, /momm(?:y|ies)/, /mommas?/, /mothers?/, /papas?/,
            /wi(?:fe|ves)/, /wom[ae]n/
          ]

          gender_mentions = spec.contains?(gender_words)

          if gender_mentions.any?
            result.add_error "Gender is mentioned", gender_mentions
            result.add_culture_fail_points gender_mentions.length / 2
          end
        end
      end

      class SexualizedTerms < Rule
        name "Sexualized Terms"
        desc "Terms like \"sexy code\" are often used if the person writing a spec doesn't know " +
              "what they are talking about or can't articulate what good code is. It can also " +
              "be an indicator of bro culture."

        def run(spec, result)
          sexualized_words = ["sexy", "hawt", "phat"]

          sexualized_mentions = spec.contains?(sexualized_words)

          if sexualized_mentions.any?
            result.add_warning "Job uses sexualized terms: " + sexualized_mentions.join(", "), sexualized_mentions
            result.add_culture_fail_points sexualized_mentions.length / 2
          end
        end
      end
    end
  end
end